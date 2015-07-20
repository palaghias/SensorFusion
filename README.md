# SensorFusion
This project performs sensor fusion to track a mobile device's orientation. The data utilised are from three sensors: 
a) Accelerometer, 
b) Magnetic Field, 
c) Gyroscope. The sensor fusion is executed off-line. 

This project basically ports code developed by Paul Lawitzki from Android to Matlab/Octave.The Matlab/Octave code imports a CSV file with a given structure. Then, a strapdown integration system is developed by computing the orientation from two different components: 

a) Accelerometer - Magnetic Field and 
b) Gravity tracking through Gyroscope. 

Finally, the orientations from the two components are fused. (http://www.thousand-thoughts.com/2012/03/android-sensor-fusion-tutorial/)  
