function [ R ] = getRotationMatrixFromVector( R, rotationVector )
% Helper function to convert a rotation vector to a rotation matrix.
%  Given a rotation vector (presumably from a ROTATION_VECTOR sensor), returns a
%  9  or 16 element rotation matrix in the array R.  R must have length 9 or 16.
%  If R.length == 9, the following matrix is returned:
% <pre>
%   /  R( 0)   R( 1)   R( 2)   \
%   |  R( 3)   R( 4)   R( 5)   |
%   \  R( 6)   R( 7)   R( 8)   /
%</pre>
% If R.length == 16, the following matrix is returned:
% <pre>
%   /  R( 0)   R( 1)   R( 2)   0  \
%   |  R( 4)   R( 5)   R( 6)   0  |
%   |  R( 8)   R( 9)   R(10)   0  |
%   \  0       0       0       1  /
%</pre>
%  @param rotationVector the rotation vector to convert
%  @param R an array of s in which to store the rotation matrix
%/
%
%   Android 5.1.0
%

    q1 = rotationVector(1);
    q2 = rotationVector(2);
    q3 = rotationVector(3);

    if (length(rotationVector) >= 4) 
        q0 = rotationVector(4);
    else 
        q0 = 1 - q1*q1 - q2*q2 - q3*q3;
        
        if (q0 > 0)
            q0 = sqrt(q0);
        else
            q0 = 0;
        end
    end
    
    sq_q1 = 2 * q1 * q1;
	sq_q2 = 2 * q2 * q2;
	sq_q3 = 2 * q3 * q3;
	q1_q2 = 2 * q1 * q2;
    q3_q0 = 2 * q3 * q0;
	q1_q3 = 2 * q1 * q3;
	q2_q0 = 2 * q2 * q0;
	q2_q3 = 2 * q2 * q3;
    q1_q0 = 2 * q1 * q0;
    
    if (length(R) == 9) 
        R(1) = 1 - sq_q2 - sq_q3;
        R(2) = q1_q2 - q3_q0;
        R(3) = q1_q3 + q2_q0;

        R(4) = q1_q2 + q3_q0;
        R(5) = 1 - sq_q1 - sq_q3;
        R(6) = q2_q3 - q1_q0;

        R(7) = q1_q3 - q2_q0;
        R(8) = q2_q3 + q1_q0;
        R(9) = 1 - sq_q1 - sq_q2;
    elseif (length(R) == 16) 
        R(1) = 1 - sq_q2 - sq_q3;
        R(2) = q1_q2 - q3_q0;
        R(3) = q1_q3 + q2_q0;
        R(4) = 0.0;

        R(5) = q1_q2 + q3_q0;
        R(6) = 1 - sq_q1 - sq_q3;
        R(7) = q2_q3 - q1_q0;
        R(8) = 0.0;

        R(9) = q1_q3 - q2_q0;
        R(10) = q2_q3 + q1_q0;
        R(11) = 1 - sq_q1 - sq_q2;
        R(12) = 0.0;

        R(13) = 0.0; R(14) = 0.0; R(15) = 0.0;
        R(16) = 1.0;
    end
end

