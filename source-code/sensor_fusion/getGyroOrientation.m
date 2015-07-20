function [ gyroOrientation, gyroMatrix ] = getGyroOrientation( gyroMatrix, dT, gyro )
% This function performs the integration of the gyroscope data.
% It writes the gyroscope based orientation into gyroOrientation.

    deltaVector = zeros(4, 1);

    % convert the raw gyro data into a rotation vector
    getRotationVectorFromGyro(gyro, deltaVector, dT / 2.0);

    % convert rotation vector into rotation matrix
    deltaMatrix = zeros(9, 1);
    getRotationMatrixFromVector(deltaMatrix, deltaVector);
     
    % apply the new rotation interval on the gyroscope based rotation matrix
    gyroMatrix = matrixMultiplication(gyroMatrix, deltaMatrix);
     
    % get the gyroscope based orientation from the rotation matrix
    gyroOrientation = getOrientation(gyroMatrix); 
end

