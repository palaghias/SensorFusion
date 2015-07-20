function [ fusedOrientation ] = getFusedOrientation( orientation, gyroOrientation )
%
% Calculate the fused orientation.
%
% orientation: it is the orientation retrieved from the accelerometer and 
%               magnetic field sensor. It contains two sources of error: 
%               accelerometer bias and magnetic disturbance.
% gyroOrientation: it is the orientation calculated from the gyroscope. It
%                   contains error due to gyroscope drift.

    FILTER_COEFFICIENT = 0.98;
    oneMinusCoeff = (1.0 - FILTER_COEFFICIENT);
 
    %
    % Fix for 179° <--> -179° transition problem: Check whether one of the
    % two orientation angles (gyro or accMag) is negative while the other
    % one is positive. If so, add 360° (2 * pi) to the negative value,
    % perform the sensor fusion, and remove the 360° from the result if it
    % is greater than 180°. This stabilizes the output in
    % positive-to-negative-transition cases.
    %
 
    % azimuth
    if (gyroOrientation(1) < -0.5 * pi && orientation(1) > 0.0)
    
        fusedOrientation(1) = (FILTER_COEFFICIENT ...
                * (gyroOrientation(1) + 2.0 * pi) + oneMinusCoeff ...
                * orientation(1));
            
        if fusedOrientation(1) > pi
            fusedOrientation(1) = fusedOrientation(1) - 2.0 * pi;
        end
    
    elseif (orientation(1) < -0.5 * pi && gyroOrientation(1) > 0.0)
    
        fusedOrientation(1) = (FILTER_COEFFICIENT ...
                * gyroOrientation(1) + oneMinusCoeff ...
                * (orientation(1) + 2.0 * pi));
            
        if fusedOrientation(1) > pi
            fusedOrientation(1) = fusedOrientation(1) - 2.0 * pi;
        end
    else
    
        fusedOrientation(1) = FILTER_COEFFICIENT * gyroOrientation(1) ...
                + oneMinusCoeff * orientation(1);
    end
 
    % pitch
    if (gyroOrientation(2) < -0.5 * pi && orientation(2) > 0.0)
    
        fusedOrientation(2) = (FILTER_COEFFICIENT ...
                * (gyroOrientation(2) + 2.0 * pi) + oneMinusCoeff ...
                * orientation(2));
            
        if fusedOrientation(2) > pi
            fusedOrientation(2) = fusedOrientation(2) - 2.0 * pi;
        end      
    
    elseif (orientation(2) < -0.5 * pi && gyroOrientation(2) > 0.0)
    
        fusedOrientation(2) = (FILTER_COEFFICIENT ...
                * gyroOrientation(2) + oneMinusCoeff ...
                * (orientation(2) + 2.0 * pi));
        
        if fusedOrientation(2) > pi
            fusedOrientation(2) = fusedOrientation(2) - 2.0 * pi;
        end
    
    else
    
        fusedOrientation(2) = FILTER_COEFFICIENT * gyroOrientation(2) ...
                + oneMinusCoeff * orientation(2);
    end
 
    % roll
    if (gyroOrientation(3) < -0.5 * pi && orientation(3) > 0.0)
    
        fusedOrientation(3) = (FILTER_COEFFICIENT ...
                * (gyroOrientation(3) + 2.0 * pi) + oneMinusCoeff ...
                * orientation(3));
        if fusedOrientation(3) > pi
            fusedOrientation(3) = fusedOrientation(3) - 2.0 * pi;
        end
    
    elseif (orientation(3) < -0.5 * pi && gyroOrientation(3) > 0.0)
  
        fusedOrientation(3) = (FILTER_COEFFICIENT ...
                * gyroOrientation(3) + oneMinusCoeff ...
                * (orientation(3) + 2.0 * pi));
        if fusedOrientation(3) > pi
            fusedOrientation(3) = fusedOrientation(3) - 2.0 * pi;
        end
                
    else
        fusedOrientation(3) = FILTER_COEFFICIENT * gyroOrientation(3)...
                + oneMinusCoeff * orientation(3);
    end
end

