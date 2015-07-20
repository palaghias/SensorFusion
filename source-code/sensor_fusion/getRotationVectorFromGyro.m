function [ deltaRotationVector ] = getRotationVectorFromGyro( gyroValues, ...
    deltaRotationVector, timeFactor )
% This function is borrowed from the Android reference
% at http://developer.android.com/reference/android/hardware/SensorEvent.html#values
% It calculates a rotation vector from the gyroscope angular speed values.

    EPSILON = 0.000000001;
    normValues = zeros(4,2);

    % Calculate the angular speed of the sample
    omegaMagnitude = sqrt(gyroValues(1) * gyroValues(1) ...
        + gyroValues(2) * gyroValues(2) ...
        + gyroValues(3) * gyroValues(3));

    % Normalize the rotation vector if it's big enough to get the axis
    if (omegaMagnitude > EPSILON) 
        normValues(1) = gyroValues(1) / omegaMagnitude;
        normValues(2) = gyroValues(2) / omegaMagnitude;
        normValues(3) = gyroValues(3) / omegaMagnitude;
    end

    % Integrate around this axis with the angular speed by the timestep
    % in order to get a delta rotation from this sample over the timestep
    % We will convert this axis-angle representation of the delta rotation
    % into a quaternion before turning it into the rotation matrix.
    thetaOverTwo = omegaMagnitude * timeFactor;
    sinThetaOverTwo = sin(thetaOverTwo);
    cosThetaOverTwo = cos(thetaOverTwo);

    deltaRotationVector(1) = sinThetaOverTwo * normValues(1);
    deltaRotationVector(2) = sinThetaOverTwo * normValues(2);
    deltaRotationVector(3) = sinThetaOverTwo * normValues(3);
    deltaRotationVector(4) = cosThetaOverTwo;
end

