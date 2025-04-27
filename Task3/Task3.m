clear all
close all

load datagsrx129

settings.sys.ls_type = 1; % 0 for OLS;  1 for WLS
settings.sys.raim_type = 1; % 0 for raim;  1 for weighted raim; 2 for no raim
settings.sys.skymask_type = 0; % 0 for no skymask;  1 for skymask filtering
[obsData, satData, navData] = doNavigation(obsData, settings, ephData);
solu_ols = navData;


NrEpoch    = size(navData, 2);
GT_llh     = [settings.nav.trueLat, settings.nav.trueLong, settings.nav.trueHeight];
GT_ecef    = llh2ecef(GT_llh.*[pi/180, pi/180, 1]);
R_mat      = R_ecef_enu(GT_llh.*[pi/180, pi/180, 1]); % transform from LLH to ENU coordinate

pos_llh = (1:3);
vel_enu = (4:6);
pos_enu = (7:9);
pos_raim = (10:13);

for i = 1: NrEpoch % loop through each epoch
    SOLU.ols(i, pos_llh) = solu_ols{1,i}.Pos.LLA;
    SOLU.ols(i, vel_enu) = (R_mat * solu_ols{1,i}.Vel.xyz')'; % ((3,3) * (1,3)')' = (1,3)
    SOLU.ols(i, pos_enu) = (R_mat * (solu_ols{1,i}.Pos.xyz - GT_ecef)' )';
    SOLU.ols(i, pos_raim) = solu_ols{1,i}.Pos.raim;
end

figure; 
geobasemap('satellite');
geoscatter(SOLU.ols(:, pos_llh(1)), SOLU.ols(:, pos_llh(2)), 30, 'filled', 'r', 'DisplayName', 'OLS'); hold on
% geoscatter(SOLU.ols_skymask(:, pos_llh(1)), SOLU.ols_skymask(:, pos_llh(2)), 30, 'filled', 'b', 'DisplayName', 'OLS with Skymask'); hold on
geoscatter(GT_llh(1), GT_llh(2), 300, 'filled', 'g', "pentagram",'MarkerEdgeColor', 'k', 'DisplayName', 'Grount Truth'); hold on
legend('show');

% Create a map with the geoplot function
figure;
ax = geoplot(SOLU.ols(:, pos_llh(1)), SOLU.ols(:, pos_llh(2)), 'ro', 'MarkerSize', 10); % Plot the estimated positions
hold on;
geoplot(GT_llh(1),  GT_llh(2), 'bo', 'MarkerSize', 10); % Plot the ground truth
% Set the limits of the map
geolimits([min(SOLU.ols(:, pos_llh(1))) max(SOLU.ols(:, pos_llh(1)))], [min(SOLU.ols(:, pos_llh(2))) max(SOLU.ols(:, pos_llh(2)))]);
% Add a basemap
geobasemap('streets');
% Add a title
title('GNSS Positioning in Urban Environment');
% Add a legend
legend('Estimated Position', 'Ground Truth');
% Add text labels for longitude and latitude
text(min(SOLU.ols(:, pos_llh(2))), max(SOLU.ols(:, pos_llh(1))), 'Longitude (°)', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom');
text(max(SOLU.ols(:, pos_llh(2))), min(SOLU.ols(:, pos_llh(1))), 'Latitude (°)', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top');
% Display the grid
grid on;



err_3d_ols = vecnorm(SOLU.ols(:, pos_enu),2,2);

mean(err_3d_ols)
std(err_3d_ols)


fde_info = SOLU.ols(:, pos_raim);
nav_info = SOLU.ols;

figure; 
hold on
plot(fde_info(:, 1), 'bo', LineWidth=1); % sqrt WSSE
plot(fde_info(:, 2), 'rx', LineWidth=1); % Threshold
xlabel("Time (epoch)")
ylabel("Test Statistics (m)")
title("Detection results")

figure
plot(fde_info(:, 3), 'rx', LineWidth=1); % PL
xlabel("Time (epoch)")
ylabel("PL (m)")
title("Protection level")

err_3d = vecnorm(nav_info(:, pos_enu), 2, 2);
pl_3d = fde_info(:, 3);
figure
hold on;
% Scatter plot of Protection Level vs. Position Error
scatter(err_3d, pl_3d, 'filled', 'bo');
ylabel('Protection Level (m)');
xlabel('Position Error (m)');
% title('Stanford Plot for OLS');
% grid on;
% Add alert limit lines
yline(50, '-r', 'LineWidth', 1.5);
xline(50, '-r', 'LineWidth', 1.5);
% Add 1:1 reference line (ideal scenario)
plot([0, 60], [0, 60], 'r-', 'LineWidth', 1);
title("Stanford Chart")

