function [ orientation ] = fuseSensors( accelerometer, magnetometer, gyroscope, timestamp )
%fuseSensors Calculates the device orientation based on the fusion of
%sensors of accelerometer, magnetic field and gyroscope.
%   accelerometer: An nx3 matrix that includes the data from accelerometer.
%   magnetometer: An nx3 matrix that includes the data from magnetic field.
%   gyroscope: An nx3 matrix that includes the data from gyroscope.
%   timestamp: An nx1 vector that includes the timestamps of the data

    MILLISECONDS_TO_SECONDS = 1/1000;
 
    % initialise gyroMatrix with identity matrix
    gyroMatrix(1) = 1.0; gyroMatrix(2) = 0.0; gyroMatrix(3) = 0.0;
    gyroMatrix(4) = 0.0; gyroMatrix(5) = 1.0; gyroMatrix(6) = 0.0;
    gyroMatrix(7) = 0.0; gyroMatrix(8) = 0.0; gyroMatrix(9) = 1.0;
    
    initState = 0;
    numsamples = size(accelerometer, 1);
    
    orientation = zeros(numsamples-1, 3);
     
    %% Compute gravity and magnetic field
    ALPHA = 0.8;
    gravity(1,:) = accelerometer(1,:);
    gravity(2:numsamples, :) = accelerometer(2:numsamples, :) * ALPHA ...
        + accelerometer(1:numsamples-1, :) * (1 - ALPHA);
    
    %% Compute orientation based on accelerometer and magnetometer
    rotationMatrix = getRotationMatrix(gravity(1,:), magnetometer(1,:));
    if (rotationMatrix) 
        accMagOrientation = getOrientation(rotationMatrix);
        orientation(1,:) = accMagOrientation;
    end
        
    %% Compute orientation
    for i=2:numsamples
        
        %% Compute orientation based on accelerometer and magnetometer
        rotationMatrix = getRotationMatrix(gravity(i,:), magnetometer(i,:));
        if (rotationMatrix) 
            accMagOrientation = getOrientation(rotationMatrix);
        end
        
        %% Compute orientation based on gyroscope
        if initState == 0
            % initialisation of the gyroscope based rotation matrix
            initMatrix = getRotationMatrixFromOrientation(accMagOrientation);
            
            gyroMatrix = matrixMultiplication(gyroMatrix, initMatrix);
            
            initState = 1;
        end
        % Time is in milliseconds, convert it to seconds
        dT = (timestamp(i,1) - timestamp(i-1,1)) * MILLISECONDS_TO_SECONDS;
        
        [ gyroOrientation ] = getGyroOrientation( gyroMatrix, dT, gyroscope(i, :) );
        
        
        %% Compute orientation by fusing data from all three sensors
        [ fusedOrientation ] = getFusedOrientation( accMagOrientation, gyroOrientation );
        
        % Refine gyroscope drift
        gyroMatrix = getRotationMatrixFromOrientation(fusedOrientation);
        
        % Store orientation
        orientation(i, :) = fusedOrientation;
    end
end

