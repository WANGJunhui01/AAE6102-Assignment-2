clear all
close all

% Ground‐truth approx position (lat,lon,alt)
lat0 = 22.3198722;
lon0 = 114.209101777778;
alt0 = 3.0;
filePath = 'C:\Users\Admin\Downloads\PolyU_AAE6102_Assignment2-main\PolyU_AAE6102_Assignment2-main\navSolutionResults.mat';

if exist(filePath, 'file')
    navSolutions1 = load(filePath);
    mask.pr = navSolutions1.navSolutions.correctedP;
    mask.az = navSolutions1.navSolutions.az;
    mask.el = navSolutions1.navSolutions.el;
    mask.pos = navSolutions1.navSolutions.satPositions;
else
    error('File not found: %s', filePath);
end

disp('Loaded Data Sizes:');
disp(size(mask.pr));
disp(size(mask.az));
disp(size(mask.el));
disp(size(mask.pos));

% Load skymask CSV
M = readmatrix('C:\Users\Admin\Downloads\PolyU_AAE6102_Assignment2-main\PolyU_AAE6102_Assignment2-main\Task2\skymask_A1_urban.csv');
mask.maskAz = M(:,1);
mask.maskEl = M(:,2);
maskElVec = nan(361,1);
for i = 1:numel(mask.maskAz)
    a = round(mod(mask.maskAz(i),360));
    maskElVec(a+1) = mask.maskEl(i);
end
idx = find(~isnan(maskElVec));
mask.maskElVec = interp1(idx-1, maskElVec(idx), (0:360)','linear','extrap');

% Convert azimuth and elevation to polar coordinates
theta = deg2rad(0:360); % Azimuth angles in radians
rho = 90 - maskElVec; % Convert elevation to radius (90 - elevation)

% Plot the skymask in polar coordinates
figure;
polarplot(theta, rho, 'LineWidth', 1.5);
title('Skymask Horizon in Polar Coordinates');
grid on;

% Add labels and annotations
rlim([0 90]); % Set the radial limits
rticks(0:10:90); % Set the radial ticks
rticklabels({'90°', '80°', '70°', '60°', '50°', '40°', '30°', '20°', '10°', '0°'}); % Set the radial tick labels
thetaticks(0:45:360); % Set the theta ticks
% thetalabels({'0°', '45°', '90°', '135°', '180°', '225°', '270°', '315°', '360°'}); % Set the theta tick labels

delta = 25;
maskRel = max(0, mask.maskElVec - delta);

% WGS‐84 ellipsoid
mask.wgs = wgs84Ellipsoid('meters');
[x0,y0,z0] = geodetic2ecef(mask.wgs,lat0,lon0,alt0);
dt0 = 0;
c   = 299792458;

[nSat, nEpoch] = size(mask.pr);
sol = nan(nEpoch,4);
nVis  = zeros(nEpoch,1);

%--------------------------------------------------------------------------
% 2. MAIN LOOP OVER EPOCHS
%--------------------------------------------------------------------------
for k = 1:nEpoch
    mask.rho_k = mask.pr(:,k);
    mask.az_k  = mask.az(:,k);
    mask.el_k  = mask.el(:,k);
    mask.Psat  = squeeze(mask.pos(:,:,k))';

    % Skymask visibility & weights
    vis = false(nSat,1);
    w   = zeros(nSat,1);
    for i = 1:nSat
        a = mod(mask.az_k(i),360);
        ai = floor(a)+1;
        el_block = maskRel(ai);
        if mask.el_k(i) > el_block
            w(i) = sin(deg2rad(mask.el_k(i) - el_block)) * sin(deg2rad(mask.el_k(i)));
            vis(i) = true;
        end
    end

    idx = find(vis);
    nVis(k) = numel(idx);
    fprintf('Visible satellites at epoch %d: %d\n', k, nVis(k));

    if numel(idx) < 4
        continue;  % cannot solve
    end

    % WLS via Gauss–Newton
    x_est = [x0; y0; z0; dt0];
    tol   = 1e-4;
    for iter = 1:10
        m = numel(idx);
        mask.H = zeros(m,4);
        mask.r = zeros(m,1);
        mask.W = diag(w(idx));

        for ii = 1:m
            i = idx(ii);
            rho_hat = norm(mask.Psat(i,:)' - x_est(1:3));
            pred    = rho_hat + c*x_est(4);
            mask.r(ii)   = mask.rho_k(i) - pred;
            u        = (x_est(1:3) - mask.Psat(i,:)') / rho_hat;
            mask.H(ii,1:3) = u';
            mask.H(ii,4)   = -c;
        end

        % Solve for Δx
        dx = (mask.H' * mask.W * mask.H) \ (mask.H' * mask.W * mask.r);
        x_est = x_est + dx;
        if norm(dx) < tol, break; end
    end

    sol(k,:) = x_est';
    x0 = x_est(1);
    y0 = x_est(2);
    z0 = x_est(3);
    dt0 = x_est(4);
end


%--------------------------------------------------------------------------
% 3. POST‐PROCESS & PLOT
%--------------------------------------------------------------------------
fprintf('Visible sats per epoch (min/max): %d / %d\n', min(nVis), max(nVis));
if max(nVis) < 4
    warning('All epochs have <4 visible sats under this mask. Relaxing mask by 2°.');

    % Try relaxing the mask by 2 degrees and re-evaluate
    maskElVec = mask.maskElVec - 2;
    sol = nan(nEpoch,4);
    for k = 1:nEpoch
        mask.rho_k = mask.pr(:,k);
        mask.az_k  = mask.az(:,k);
        mask.el_k  = mask.el(:,k);
        mask.Psat  = squeeze(mask.pos(:,:,k))';

        vis = false(nSat,1);
        w   = zeros(nSat,1);
        for i = 1:nSat
            a = mod(mask.az_k(i),360);
            ai = floor(a)+1;
            el_block = maskElVec(ai);
            if mask.el_k(i) > el_block
                w(i) = sin(deg2rad(mask.el_k(i) - el_block)) * sin(deg2rad(mask.el_k(i)));
                vis(i) = true;
            end
        end

        idx = find(vis);
        if numel(idx) < 4, continue; end

        x_est = [x0; y0; z0; dt0];
        for iter = 1:10
            m = numel(idx);
            mask.H = zeros(m,4);
            mask.r = zeros(m,1);
            mask.W = diag(w(idx));

            for ii = 1:m
                i = idx(ii);
                rho_hat = norm(mask.Psat(i,:)' - x_est(1:3));
                pred = rho_hat + c * x_est(4);
                mask.r(ii) = mask.rho_k(i) - pred;
                u = (x_est(1:3) - mask.Psat(i,:)') / rho_hat;
                mask.H(ii,1:3) = u';
                mask.H(ii,4) = -c;
            end

            dx = (mask.H' * mask.W * mask.H) \ (mask.H' * mask.W * mask.r);
            x_est = x_est + dx;
            if norm(dx) < tol, break; end
        end

        sol(k,:) = x_est';
        x0 = x_est(1);
        y0 = x_est(2);
        z0 = x_est(3);
        dt0 = x_est(4);
    end
end


valid = find(~any(isnan(sol),2));
if isempty(valid)
    disp('No valid solutions to convert to geodetic coordinates.');
    return;
end

[lat, lon, ~] = ecef2geodetic(mask.wgs, sol(valid,1), sol(valid,2), sol(valid,3));
if isempty(lat) || isempty(lon)
    disp('No valid latitude and longitude values to plot.');
    return;
end

% Plot results
% Calculate the IQR for latitude and longitude
Q1_lon = prctile(lon, 25);
Q3_lon = prctile(lon, 75);
IQR_lon = Q3_lon - Q1_lon;

Q1_lat = prctile(lat, 25);
Q3_lat = prctile(lat, 75);
IQR_lat = Q3_lat - Q1_lat;

% Define the thresholds
lower_bound_lon = Q1_lon - 1.5 * IQR_lon;
upper_bound_lon = Q3_lon + 1.5 * IQR_lon;

lower_bound_lat = Q1_lat - 1.5 * IQR_lat;
upper_bound_lat = Q3_lat + 1.5 * IQR_lat;

% Remove outliers
valid_indices = (lon >= lower_bound_lon) & (lon <= upper_bound_lon) & ...
                (lat >= lower_bound_lat) & (lat <= upper_bound_lat);

lon_clean = lon(valid_indices);
lat_clean = lat(valid_indices);

% Plot original data and data after removing outliers
figure;
subplot(1, 2, 1);
scatter(lon, lat, 'b.');
title('Original Data');
xlabel('Longitude');
ylabel('Latitude');
hold on;
plot([lower_bound_lon, lower_bound_lon], [min(lat), max(lat)], 'k--');
plot([upper_bound_lon, upper_bound_lon], [min(lat), max(lat)], 'k--');
plot([min(lon), max(lon)], [lower_bound_lat, lower_bound_lat], 'k--');
plot([min(lon), max(lon)], [upper_bound_lat, upper_bound_lat], 'k--');
hold off;

subplot(1, 2, 2);
scatter(lon_clean, lat_clean, 'r.');
title('Data After Removing Outliers');
xlabel('Longitude');
ylabel('Latitude');
hold on;
plot([lower_bound_lon, lower_bound_lon], [lower_bound_lat, upper_bound_lat], 'k--');
plot([upper_bound_lon, upper_bound_lon], [lower_bound_lat, upper_bound_lat], 'k--');
plot([lower_bound_lon, upper_bound_lon], [lower_bound_lat, lower_bound_lat], 'k--');
plot([lower_bound_lon, upper_bound_lon], [upper_bound_lat, upper_bound_lat], 'k--');
hold off;

% Create a map with the geoplot function
figure;
ax = geoplot(lat_clean, lon_clean, 'ro', 'MarkerSize', 10); % Plot the estimated positions
hold on;
geoplot(lat0, lon0, 'bo', 'MarkerSize', 10); % Plot the ground truth
% Set the limits of the map
geolimits([min(lat_clean) max(lat_clean)], [min(lon_clean) max(lon_clean)]);
% Add a basemap
geobasemap('streets');
% Add a title
title('GNSS Positioning in Urban Environment');
% Add a legend
legend('Estimated Position', 'Ground Truth');
% Add text labels for longitude and latitude
text(min(lon_clean), max(lat_clean), 'Longitude (°)', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom');
text(max(lon_clean), min(lat_clean), 'Latitude (°)', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top');
% Display the grid
grid on;