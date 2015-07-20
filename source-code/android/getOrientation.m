function [values] = getOrientation(R, values)
         %
         % 4x4 (length=16) case:
         %   /  R[ 0]   R[ 1]   R[ 2]   0  \
         %   |  R[ 4]   R[ 5]   R[ 6]   0  |
         %   |  R[ 8]   R[ 9]   R[10]   0  |
         %   \      0       0       0   1  /
         %   
         % 3x3 (length=9) case:
         %   /  R[ 0]   R[ 1]   R[ 2]  \
         %   |  R[ 3]   R[ 4]   R[ 5]  |
         %   \  R[ 6]   R[ 7]   R[ 8]  /
         % 
         %
         %  Android 5.1.0
         %

        if length(R) == 9
            values(1) = atan2(R(2), R(5));
            values(2) = asin(-R(8));
            values(3) = atan2(-R(7), R(9));
        else
            values(1) = atan2(R(2), R(6));
            values(2) = asin(-R(10));
            values(3) = atan2(-R(9), R(11));
        end
end