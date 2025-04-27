# AAE6102 Satellite Communication and Navigation

## Assignment 2

**Due Date:** 1 May 2025  
**Student Name:** WANG Junhui  
**Student ID:** 23038168r  

---

## Table of Contents

1. [Task 1 – Differential GNSS Positioning](#task-1--differential-gnss-positioning)
2. [Task 2 – GNSS in Urban Areas](#task-2--gnss-in-urban-areas)
3. [Task 3 – GPS RAIM (Receiver Autonomous Integrity Monitoring)](#task-3--gps-raim-receiver-autonomous-integrity-monitoring)
4. [Task 4 – LEO Satellites for Navigation](#task-4--leo-satellites-for-navigation)
5. [Task 5 – GNSS Remote Sensing](#task-5--gnss-remote-sensing)

---

## Task 1 – Differential GNSS Positioning
```
Model: ChatGPT 4o
Prompt: Please help me compare the pros and cons of DGNSS, RTK, PPP and PPP-RTK for smartphone navigation
Chatroom Link: https://poe.com/s/1kRQkqaf1oqQxT60vj1W
```


### Comparative Analysis of GNSS Techniques for Smartphone Navigation

Global Navigation Satellite Systems (GNSS) have become an indispensable part of modern technology, providing precise positioning, navigation, and timing services. In the context of smartphone navigation, several advanced GNSS techniques have emerged to enhance accuracy and reliability. This essay will compare the pros and cons of Differential GNSS (DGNSS), Real-Time Kinematic (RTK), Precise Point Positioning (PPP), and PPP-RTK, focusing on their suitability for smartphone applications.

#### Differential GNSS (DGNSS)
DGNSS improves positional accuracy by using correction data from nearby reference stations to reduce errors in GNSS signals. It achieves sub-meter accuracy, which is sufficient for most consumer navigation applications like driving, hiking, and recreational sports. The method is relatively simple and cost-effective compared to other high-precision techniques. Since many smartphones can already receive standard GNSS signals, DGNSS corrections can often be implemented with minimal additional hardware. DGNSS also benefits from a wide coverage area if there are sufficient ground stations or a reliable network of reference stations.

Despite its advantages, DGNSS has limitations. Its accuracy is limited to sub-meter levels, which may not be sufficient for precision-demanding applications such as autonomous driving or surveying. Additionally, its effectiveness depends on the availability of nearby reference stations, making DGNSS reliant on local infrastructure. In urban areas, where signals are prone to blockage and multipath interference, DGNSS performance can degrade significantly. Furthermore, the latency of correction data can pose challenges in real-time scenarios.

#### Real-Time Kinematic (RTK)
RTK is a high-precision GNSS technique that achieves centimeter-level accuracy by using carrier-phase measurements and correction data from a base station or RTK network. It is ideal for applications requiring extremely precise positioning, such as autonomous vehicles, drone navigation, and precision agriculture. RTK corrections are delivered in real-time, enabling instantaneous improvements in positional accuracy. This makes RTK highly reliable in open environments with clear satellite visibility, where it can deliver consistent and repeatable results.

RTK, however, has significant infrastructure requirements, as it needs a nearby base station or access to an RTK correction network. The operational range of RTK is limited, typically to within a few tens of kilometers from the base station, which restricts its use in remote areas. RTK is also costly due to the need for specialized hardware and subscription services for correction data. Additionally, it is highly sensitive to signal obstructions and multipath effects, making it less reliable in urban areas or dense forests. For smartphones, RTK poses challenges in terms of power consumption and computational complexity, which may drain the battery quickly during prolonged use.

#### Precise Point Positioning (PPP)
PPP is a globally applicable technique that achieves high positional accuracy by using satellite orbit and clock corrections, along with atmospheric models, without the need for a local base station. It offers decimeter-level accuracy or better, making it suitable for applications where sub-meter precision is sufficient. One of PPP’s greatest advantages is its global coverage, as it does not rely on local infrastructure. This makes it particularly useful in remote or underdeveloped areas where ground-based reference stations are unavailable. PPP is also cost-effective compared to RTK, as it requires only a GNSS receiver and access to correction services.

The major drawback of PPP is its slow convergence time, which can take several minutes to over 30 minutes to achieve optimal accuracy. This delay limits its usefulness in real-time applications, such as turn-by-turn navigation or autonomous driving. Additionally, PPP performance can degrade in urban environments, where multipath interference and signal obstructions are common. Smartphones implementing PPP must also handle continuous correction data, which can increase data usage and power consumption.

#### PPP-RTK
PPP-RTK combines the strengths of both PPP and RTK, offering centimeter-level accuracy with fast convergence times. It uses global satellite corrections from PPP and local RTK-like corrections to improve the convergence time and accuracy. This hybrid approach provides the global coverage of PPP while retaining the real-time capabilities of RTK. PPP-RTK is highly versatile and suitable for precision-demanding applications like autonomous vehicles, precision agriculture, and advanced augmented reality (AR) applications. It is also more robust in areas with sparse infrastructure compared to standalone RTK, as it relies on both global and local correction data.

The major drawback of PPP-RTK is its complexity and high cost. Implementing this technique requires access to both global correction services and local RTK networks, which increases the infrastructure and subscription costs. Although it is more robust than RTK in some scenarios, PPP-RTK is still susceptible to signal obstructions and multipath interference in urban environments. For smartphones, the high computational and data demands of PPP-RTK can strain battery life and increase operational costs.

#### Comparison Across Key Aspects

| **Aspect**        | **DGNSS**      | **RTK**            | **PPP**           | **PPP-RTK**         |
|--------------------|----------------|--------------------|-------------------|---------------------|
| **Accuracy**       | Sub-meter      | Centimeter-level   | Decimeter-level   | Centimeter-level    |
| **Convergence**    | Fast           | Instantaneous      | Slow (30+ mins)   | Fast (minutes)      |
| **Coverage**       | Local          | Local              | Global            | Global + Local      |
| **Cost**           | Low            | High               | Moderate          | High                |
| **Smartphone Use** | Suitable       | Limited            | Moderate          | Limited             |
| **Limitations**    | Limited accuracy | Signal obstructions | Slow convergence  | High cost and complexity |

#### Conclusion
The choice of GNSS technique for smartphone navigation depends on the specific application and environment. DGNSS is well-suited for casual navigation, offering a good balance of accuracy and cost-effectiveness. RTK provides unparalleled accuracy for high-precision tasks but is limited by its infrastructure requirements and sensitivity to signal obstructions. PPP is a practical option for scenarios requiring global coverage and moderate accuracy, though its slow convergence time is a drawback for real-time applications. PPP-RTK, while promising in combining accuracy and coverage, is currently limited by its complexity and high cost, making it less accessible for widespread smartphone use.

---

## Task 2 – GNSS in Urban Areas


### Enhancing GNSS Positioning Accuracy in Urban Environments Using Skymask-Aided WLS positioning method
Urban environments present significant challenges to the accuracy and reliability of Global Navigation Satellite System (GNSS) positioning. Signal blockage, multipath effects, and poor satellite visibility hinder the performance of GNSS-based systems in these areas. To address these challenges, the skymask-aided GNSS positioning method has been developed, leveraging satellite visibility data to improve accuracy. This essay discusses the methodologies involved in this approach, focusing on the role of the skymask, outlier removal, and visualization of results.

#### Methodology
##### Skymask for Satellite Visibility
A skymask is a critical tool in mitigating the effects of signal blockage and poor satellite visibility in urban environments. By identifying areas where satellites are obstructed, the skymask provides azimuth and elevation angles to determine satellite visibility. The skymask data is typically stored as a vector of elevation angles corresponding to azimuth angles from 0 to 360 degrees. This data is processed into a continuous and smooth blocking elevation vector through interpolation. Fig. 1 depicts the sky horizon in polar coordinates. For each satellite, if its elevation angle exceeds the blocking elevation angle from the skymask, the satellite is considered visible. This process ensures that only reliable satellite measurements are used in positioning calculations, thus improving accuracy.

 ![image](https://github.com/user-attachments/assets/0625fbcd-eb9e-4cce-bd3f-73078160c5cf)
 
Fig.1 Sky horizon in polar coordinates
##### Outlier Removal Using IQR
Outliers can significantly impact the accuracy of GNSS positioning. To address this, the Interquartile Range (IQR) method is used to identify and remove outliers from the dataset. The IQR for latitude and longitude is computed, with lower and upper bounds defined as Q1 - 1.5 × IQR and Q3 + 1.5 × IQR, respectively. Data points falling outside these bounds are classified as outliers and excluded from the final results. This step ensures that the estimated positions are free from the influence of erroneous measurements, enhancing reliability. Fig. 2 illustrates the comparison between the estimated positions before and after IQR processing.

 ![image](https://github.com/user-attachments/assets/901f69c5-10cc-4044-ba60-563afbb70c57)
 
Fig.2 Estimated positions before and after IQR processing.
##### Plotting Results
To evaluate the effectiveness of the skymask-aided WLS method, the estimated positions are visualized on a map alongside the ground truth, shown in Fig. 3. Using MATLAB’s geoplot function, the results are plotted with a basemap to provide geographical context. The map includes labeled axes for longitude and latitude, along with a title and legend for clarity. This visualization provides an intuitive way to assess the accuracy and performance of the method.

 ![image](https://github.com/user-attachments/assets/933d391a-dcc9-4418-bdab-7447a739a4e5)
 
Fig. 3 GNSS positioning results in urban environments


#### Conclusion
The skymask-aided WLS GNSS positioning method offers a robust solution to the challenges of urban GNSS positioning. By filtering obstructed satellites, leveraging WLS for precise estimation, relaxing the skymask when necessary, and removing outliers, this approach effectively addresses the issues of signal blockage and poor satellite visibility. The visualization of results demonstrates its ability to improve positioning accuracy in urban environments. Future research could explore further refinements to the skymask and additional techniques to mitigate multipath effects, advancing the overall reliability of GNSS positioning in challenging environments.

#### References
[1] Walter, T., & Enge, P. (1995, September). Weighted RAIM for precision approach. In Proceedings of Ion GPS (Vol. 8, No. 1, pp. 1995-2004). Institute of Navigation. https://web.stanford.edu/group/scpnt/gpslab/pubs/papers/Walter_IONGPS_1995_wraim.pdf

[2] Hofmann-Wellenhof, B., Lichtenegger, H., & Wasle, E. (2008). GNSS—Global Navigation Satellite Systems: GPS, GLONASS, Galileo, and more. Springer.


---

## Task 3 – GPS RAIM (Receiver Autonomous Integrity Monitoring)

Receiver Autonomous Integrity Monitoring (RAIM) is a critical technique used to detect and exclude faulty GPS measurements, thereby improving the reliability and accuracy of positioning solutions. This report outlines the development and implementation of a classic weighted RAIM algorithm to process the provided "Open-Sky" data. The algorithm is based on the weighted least squares (WLS) method and includes the computation of the 3D protection level (PL) and the evaluation of GNSS integrity monitoring performance using a Stanford Chart analysis.
### Methodology
#### Weighted Least Squares (WLS) Positioning
The WLS method is used to estimate the receiver's position and clock bias. The key steps are:
1.	Initialize Position: Start with an initial position estimate.
2.	Calculate Residuals: Compute the residuals between the observed pseudoranges and the calculated ranges.
3.	Form Design Matrix: Construct the design matrix HH using the direction cosines of the satellite-receiver vectors.
4.	Weighting Matrix: Create a weighting matrix WW based on the carrier-to-noise ratio (C/N0) of the received signals.
5.	Solve for Position: Use the WLS equation to solve for the position and clock bias: $\Delta x = (H^TWH)^{-1}H^TWdR$.
6.	Update Position: Update the position and clock bias estimates using the solution from the WLS equation.
#### Weighted RAIM Algorithm
The weighted RAIM algorithm is used to detect and exclude faulty measurements. The key steps are:
1.	Chi-Squared Test: Compute the weighted sum of squared residuals (WSSE) and compare it to a threshold.
2.	Threshold Calculation: The threshold is calculated using the chi-squared distribution: $\text{Threshold} = \chi^2_{1-P_{fa}, \text{DOF}}$ , 
where $P_{fa}$ is the probability of false alarm and DOF is the number of measurements minus 4.
3.	Fault Detection: If the WSSE exceeds the threshold, a fault is detected.
4.	Fault Isolation: Isolate the faulty satellite by removing one satellite at a time and re-computing the WSSE. If the WSSE falls below the threshold, the removed satellite is identified as faulty.
#### Computation of 3D Protection Level (PL)
The 3D protection level (PL) is computed to ensure the integrity of the positioning solution. The key steps are:
1.	Design Matrix Inverse: Compute the inverse of the design matrix $H$: $(H^TWH)^{-1}$
2.	Protection Level Calculation: The PL is calculated using: $PL = k \cdot \sigma \cdot \sqrt{\text{diag}((H^TWH)^{-1})}$, 
where $k$ is a factor based on the probability of missed detection $P_{md}$ and $\sigma$ is the standard deviation of the pseudorange measurements.
#### Stanford Chart Analysis
The Stanford Chart is used to evaluate the GNSS integrity monitoring performance. The key steps are:
1.	Plot Position Error vs. Protection Level: Plot the position error (3D) against the protection level (PL).
2.	Add Alert Limit Lines: Add horizontal and vertical lines at the 3D alarm limit (AL) of 50 meters.
3.	Add 1:1 Reference Line: Add a 1:1 reference line to indicate the ideal scenario where the position error equals the protection level.
### Results
#### Detection Results
Fig. 4 shows the GNSS positioning results in the opensky environment. Fig.5 shows the test statistics (sqrt WSSE) and the threshold over time. The blue circle represents the sqrt WSSE, and the red circle represents the threshold. If the sqrt WSSE exceeds the threshold, a fault is detected.

![image](https://github.com/user-attachments/assets/115495cd-91d9-4325-a381-31b631349376)
	
Fig.4 GNSS positioning results in the opensky environment

![image](https://github.com/user-attachments/assets/22f127cf-e2c1-4584-a45a-4c377baff9bc)

Fig. 5 Detection results

#### Protection Level
Fig. 6 shows the 3D protection level (PL) over time. The red line represents the PL, which indicates the maximum possible position error with a specified confidence level.

![image](https://github.com/user-attachments/assets/bce2ac20-3e4e-46fa-ad3c-70dc001b30eb)

Fig. 6 Protection level
#### Stanford Chart
Fig. 7 is the Stanford Chart, which plots the position error (3D) against the protection level (PL). The black dashed lines represent the 3D alarm limit (AL) of 50 meters. The 1:1 reference line indicates the ideal scenario where the position error equals the protection level.

![image](https://github.com/user-attachments/assets/85fdd51c-a017-48fc-89dc-8fae80dbf86f)
 
Fig. 7 Stanford chart


### Conclusion
The RAIM algorithm effectively detects and excludes faulty measurements, as indicated by the detection results plot. The sqrt WSSE remains below the threshold most of the time, indicating that the positioning solution is reliable. The computed 3D protection level (PL) provides a measure of the integrity of the positioning solution. The PL values are generally below the 3D alarm limit (AL) of 50 meters, ensuring that the position errors are within acceptable limits. The Stanford Chart analysis confirms that the position errors are generally below the 3D alarm limit (AL) of 50 meters. Most points lie below the 1:1 reference line, indicating that the protection level is conservative and provides a high level of integrity.
The implementation of the classic weighted RAIM algorithm successfully improves and monitors the positioning performance by detecting and excluding faulty GPS measurements. The computation of the 3D protection level (PL) and the evaluation of GNSS integrity monitoring performance using a Stanford Chart analysis provide valuable insights into the reliability and accuracy of the positioning solution. The results demonstrate that the RAIM algorithm effectively ensures the integrity of the GPS positioning system.

---

## Task 4 – LEO Satellites for Navigation

```
Model: ChatGPT 4o
Prompt: Please discuss the difficulties and challenges of using LEO communication satellites for GNSS navigation
Chatroom Link: https://poe.com/s/c9tyn7tvd63rGdzuguBQ
```


### Difficulties and Challenges of Using LEO Communication Satellites for GNSS Navigation

The rise of Low Earth Orbit (LEO) communication satellite constellations, such as SpaceX’s Starlink, OneWeb, and Amazon’s Project Kuiper, has opened new possibilities for GNSS (Global Navigation Satellite System) navigation. These constellations, which consist of hundreds to thousands of satellites in orbits ranging from 300 to 1,500 km above Earth, promise improved positioning, navigation, and timing (PNT) services by complementing or augmenting traditional GNSS systems (e.g., GPS, Galileo, GLONASS, BeiDou). However, integrating LEO communication satellites into GNSS navigation presents several significant challenges and difficulties.

#### Orbital Dynamics and Satellite Visibility
One of the key challenges of using LEO satellites for GNSS navigation is their low altitude and high orbital velocity. LEO satellites orbit the Earth at speeds of approximately 7.8 km/s, completing one orbit in about 90–120 minutes. This rapid movement creates a constantly changing geometry between the satellites and users on the ground. As a result, the visibility of any single satellite is limited to just a few minutes, requiring a dense constellation to ensure continuous coverage. The rapid movement also necessitates frequent handoffs between satellites, increasing the complexity of maintaining a stable and accurate navigation solution. Additionally, the high speed of LEO satellites introduces significant Doppler shifts in the transmitted signals, which complicates signal acquisition, tracking, and processing for navigation purposes.

#### Massive Constellation Size and Deployment Costs
To provide continuous global coverage, LEO constellations require thousands of satellites in orbit. For example, Starlink aims to deploy over 12,000 satellites, while OneWeb plans for a constellation of around 6,000 satellites. Building, launching, and maintaining such large constellations require substantial financial investment. Although reusable rockets have reduced launch costs, the scale of these projects remains a significant financial challenge. Furthermore, LEO satellites have shorter lifespans (typically 5–7 years) compared to traditional GNSS satellites in medium Earth orbit (MEO), requiring frequent satellite replacements and adding to operational costs. The large number of satellites also increases the risk of orbital collisions and space debris generation, leading to potential disruptions in the constellation and long-term risks for other space missions.

#### Signal Design and Compatibility
LEO satellites are primarily designed for communication purposes, and adapting their signals for GNSS navigation introduces additional challenges. Unlike traditional GNSS satellites, which use specific frequencies optimized for navigation, LEO communication satellites transmit signals at higher frequencies (e.g., Ku, Ka, or V bands). This creates compatibility issues with existing GNSS receivers. Designing new multi-frequency receivers or modifying LEO satellite signals to include navigation features such as pseudorandom noise (PRN) codes and precise timing data is a complex task. Additionally, LEO communication signals could potentially interfere with traditional GNSS signals, especially if they operate in adjacent frequency bands. Ensuring coexistence without signal degradation is critical for reliable navigation.

#### Time Synchronization and Orbit Determination
Accurate GNSS navigation depends on precise time synchronization and knowledge of satellite orbits. For LEO satellites, achieving these requirements is challenging. Traditional GNSS satellites rely on highly stable atomic clocks for precise timing, but LEO satellites typically lack such advanced clocks due to size, weight, and power constraints. Implementing or simulating atomic clock-level precision in LEO constellations remains a technical hurdle. Furthermore, LEO satellites experience higher atmospheric drag due to their low altitude, causing their orbits to change more frequently than MEO satellites. This requires continuous orbit determination and updates, which place additional demands on ground control systems and user devices.

#### Latency and Computational Complexity
Integrating LEO satellites into GNSS navigation systems introduces additional computational and latency challenges. The high velocity and large number of satellites require frequent updates to satellite positions and Doppler corrections, increasing the computational load on receivers. Smartphones and other low-power devices may struggle to handle this additional processing efficiently. To provide real-time navigation services, LEO satellites must minimize latency in delivering correction data and position updates. Achieving near-instantaneous communication between ground stations, LEO satellites, and user devices is technically demanding and could be affected by network congestion or signal delays.

#### Integration with Existing GNSS Systems
LEO satellites are not intended to replace traditional GNSS systems but rather to augment them. Integrating LEO-based navigation with existing GNSS systems presents several challenges. Users would need hybrid receivers capable of processing signals from both traditional GNSS satellites (in MEO) and LEO satellites. Developing cost-effective, multi-system receivers that can seamlessly integrate these signals is a significant challenge. Additionally, combining data from LEO satellites with traditional GNSS signals to calculate a unified navigation solution requires advanced algorithms and software. This fusion must account for differences in signal types, delays, and error sources, further increasing system complexity.

#### Environmental and Regulatory Challenges
The deployment and operation of large LEO constellations face environmental and regulatory difficulties. The sheer number of LEO satellites has raised concerns about increased light pollution, which affects astronomical observations and has drawn criticism from the scientific community. Public backlash could lead to stricter regulations on satellite launches or operations. Additionally, the use of radio frequencies for LEO satellite communication and navigation must comply with international regulations. The limited availability of spectrum and competition among satellite operators could hinder the implementation of LEO-based navigation systems.

#### Conclusion
Using LEO communication satellites for GNSS navigation offers promising benefits, such as improved positioning accuracy, faster signal acquisition, and global coverage. However, the challenges are substantial. These include the short visibility windows and high velocity of LEO satellites, the need for massive constellations and associated costs, signal design and compatibility issues, time synchronization and orbit determination requirements, increased computational demands, and integration with existing GNSS systems. Environmental and regulatory concerns further complicate the deployment and operation of LEO-based navigation systems.
Despite these challenges, advances in satellite technology, hybrid receiver designs, and efficient algorithms may enable LEO constellations to play a significant role in the future of GNSS navigation. If successfully implemented, such systems could revolutionize navigation by providing enhanced accuracy, robustness, and reliability in environments where traditional GNSS systems struggle, such as urban canyons and remote areas.

---

## Task 5 – GNSS Remote Sensing

```
Model: ChatGPT 4o
Prompt: Please help me discuss the impact of GNSS in remote sensing of GNSS seismology
Chatroom Link: https://poe.com/s/zh8DLdBdqQa9HNMco8zZ 
```

### The Impact of GNSS in Remote Sensing of GNSS Seismology
Global Navigation Satellite Systems (GNSS) have revolutionized the field of remote sensing, particularly in the domain of GNSS seismology. This innovative approach leverages GNSS data to monitor and study seismic events, providing critical insights into earthquake processes and their effects. The integration of GNSS into seismology has expanded our ability to monitor, analyze, and respond to seismic events, offering a more comprehensive and precise understanding of earthquake dynamics.
#### High-Precision Ground Motion Monitoring
One of the most significant impacts of GNSS in seismology is its ability to enable high-precision ground motion monitoring. Unlike traditional seismometers, which measure ground acceleration or velocity, GNSS captures actual ground movement in three dimensions: latitude, longitude, and elevation. This capability is particularly impactful because it provides real-time data on tectonic shifts and crustal deformation. GNSS can measure slow-moving phenomena like aseismic creep or post-seismic relaxation, which traditional seismic instruments might miss. By capturing these subtle movements, GNSS offers a more complete picture of the dynamic processes occurring within the Earth's crust, enhancing our understanding of seismic activity and its underlying mechanisms.
#### Real-Time Earthquake Early Warning Systems
GNSS plays a critical role in earthquake early warning systems by detecting large-scale ground deformation associated with major earthquakes. One of the key contributions of GNSS is its ability to quickly estimate the magnitude of large earthquakes, especially for events where traditional seismic estimates saturate, such as those with magnitudes greater than 7.5. By tracking surface deformation in real time, GNSS helps map the extent and progression of fault ruptures. This real-time data is crucial for rapid assessment and response, as it allows for more accurate and timely early warnings. Combining GNSS data with traditional seismic networks enhances the accuracy and speed of these early warnings, providing a more robust and reliable system for earthquake monitoring and response.
#### Tsunami Early Warning
GNSS is also instrumental in tsunami early warning systems by providing critical data on vertical ground displacements that indicate potential undersea earthquakes and subsequent tsunami generation. GNSS data helps assess whether an earthquake has triggered significant seafloor uplift or subsidence, which are key indicators of tsunami generation. Accurate displacement data improves tsunami simulation models, leading to better predictions of wave height, arrival times, and impacted areas. This enhanced predictive capability is crucial for effective disaster preparedness and response, potentially saving lives and reducing the impact of these catastrophic events.
#### Long-Term Tectonic Studies
GNSS contributes to our understanding of long-term tectonic processes by providing continuous, high-precision measurements of crustal movement. GNSS networks track the relative motion of tectonic plates over time, offering insights into strain accumulation along faults. This long-term monitoring is essential for understanding the earthquake cycle, as it helps quantify interseismic strain buildup, co-seismic displacement, and post-seismic relaxation. By providing a detailed and continuous record of crustal movement, GNSS data contributes to the development of more accurate models of the earthquake cycle, which are crucial for hazard assessment and risk management.
#### Complementing Traditional Seismic Networks
GNSS enhances traditional seismic networks in several ways. It provides displacement data that complements the acceleration and velocity records from seismometers, offering a more complete picture of ground motion. GNSS is less affected by saturation during large earthquakes, making it more reliable for capturing extreme ground motion. Additionally, GNSS offers coverage in areas where seismic networks are sparse or nonexistent, especially in remote or offshore regions. This expanded coverage is particularly valuable for monitoring seismic activity in regions that are otherwise difficult to study, ensuring a more comprehensive and global understanding of seismic events.
#### Advances in Multi-GNSS Systems
The availability of multiple GNSS constellations (e.g., GPS, GLONASS, Galileo, BeiDou) has improved the accuracy, reliability, and global coverage of GNSS-based seismology. Multi-GNSS allows for denser observation networks, improving spatial resolution and providing more comprehensive data. GNSS networks can now provide data from remote regions, including oceans and polar areas, where traditional seismic instruments are impractical. This global coverage is essential for a more complete and accurate understanding of seismic activity on a global scale, enhancing our ability to monitor and respond to seismic events in even the most remote areas.
#### Challenges and Limitations
While GNSS has revolutionized seismology, some challenges remain. GNSS signals can be affected by atmospheric conditions, multipath effects, and signal blockages in urban or forested areas. Deploying and maintaining dense GNSS networks is resource-intensive, especially in developing regions. High-precision GNSS seismology requires advanced processing techniques, such as Precise Point Positioning or Real-Time Kinematics, and significant computational resources. Despite these challenges, the benefits of GNSS in seismology are substantial and continue to drive advancements in the field.
#### Conclusion
The integration of GNSS into seismology has expanded our ability to monitor, analyze, and respond to seismic events. By providing precise, real-time measurements of ground motion, GNSS complements traditional seismic methods and enhances our understanding of earthquake processes. The high-precision ground motion monitoring, real-time earthquake early warning systems, tsunami early warning, long-term tectonic studies, and the enhancement of traditional seismic networks are all critical contributions of GNSS to seismology. As GNSS technology and data processing techniques continue to evolve, its role in seismology is expected to grow, leading to more accurate predictions, better hazard assessments, and improved disaster preparedness. The future of seismology is bright with the continued integration and advancement of GNSS technology.

---

**Contact Information:**  
- **Name:** WANG Junhui  
- **Email:** junhui01.wang@connect.polyu.hk
