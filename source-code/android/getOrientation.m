function [values] = getOrientation(R, values)
%
% Copyright (C) 2008 The Android Open Source Project
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%      http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%
%
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
