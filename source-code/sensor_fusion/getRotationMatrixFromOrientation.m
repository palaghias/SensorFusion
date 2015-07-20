function [ resultMatrix ] = getRotationMatrixFromOrientation( o )
 
        xM = zeros(9, 1);
        yM = zeros(9, 1);
        zM = zeros(9, 1);
     
        sinX = sin(o(2));
        cosX = cos(o(2));
        sinY = sin(o(3));
        cosY = cos(o(3));
        sinZ = sin(o(1));
        cosZ = cos(o(1));
     
        % rotation about x-axis (pitch)
        xM(1) = 1.0; xM(2) = 0.0; xM(3) = 0.0;
        xM(4) = 0.0; xM(5) = cosX; xM(6) = sinX;
        xM(7) = 0.0; xM(8) = -sinX; xM(9) = cosX;
     
        % rotation about y-axis (roll)
        yM(1) = cosY; yM(2) = 0.0; yM(3) = sinY;
        yM(4) = 0.0; yM(5) = 1.0; yM(6) = 0.0;
        yM(7) = -sinY; yM(8) = 0.0; yM(9) = cosY;
     
        % rotation about z-axis (azimuth)
        zM(1) = cosZ; zM(2) = sinZ; zM(3) = 0.0;
        zM(4) = -sinZ; zM(5) = cosZ; zM(6) = 0.0;
        zM(7) = 0.0; zM(8) = 0.0; zM(9) = 1.0;
     
        % rotation order is y, x, z (roll, pitch, azimuth)
        resultMatrix = matrixMultiplication(xM, yM);
        resultMatrix = matrixMultiplication(zM, resultMatrix);
end

