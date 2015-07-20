function [ Q ] = getQuaternionFromVector( rv )
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
 %% Helper function to convert a rotation vector to a normalized quaternion.
 %  Given a rotation vector (presumably from a ROTATION_VECTOR sensor), returns a normalized
 %  quaternion in the array Q.  The quaternion is stored as [w, x, y, z]
 %  @param rv the rotation vector to convert
 %  @param Q an array of floats in which to store the computed quaternion
 %
 %  Android 5.1.0
 %
   
    if (length(rv) == 4) 
        Q(1) = rv(4);
    else 
        Q(1) = 1 - rv(1)*rv(1) - rv(2)*rv(2) - rv(3)*rv(3);
        if Q(1) > 0
            Q(1) = sqrt(Q(1));
        else
            Q(1) = 0;
        end
    end

    Q(2) = rv(1);
    Q(3) = rv(2);
    Q(4) = rv(3);
end

