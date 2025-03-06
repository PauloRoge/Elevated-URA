# **Far-Field 2D Localization with Elevated URA**  
This repository contains the implementation of a user localization algorithm based on an **Elevated Uniform Rectangular Array (URA)**. The model utilizes advanced position estimation techniques, leveraging the spatial phase variations of received signals to enhance localization accuracy.  

## 📌 **Features**  
- **Antenna Array Design**: Elevated URA  
- **Scenario**: Free space with Line-of-Sight  
- **System**: MIMO, Massive MIMO  
- **Simulation of signal propagation in an elevated URA**  
- **Analysis of the impact of elevation on spatial diversity and localization**  
- **Modeling with exact Euclidean distance and far-field approximation**  

## 📌 **File Description**  

| File                   | Description                                   |
|------------------------|----------------------------------------------|
| `main.m`              | Main simulation code                         |
| `signals_URA.m`       | Generates/processes signals                  |
| `responsearray_URA.m` | Steering vector model with embedded path loss |
| `steering_vector_URA.m` | Steering vector model without path loss (for MUSIC) |
| `music_URA.m`         | Implementation of the MUSIC algorithm        |
