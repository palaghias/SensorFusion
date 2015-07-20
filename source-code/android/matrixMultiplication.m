function [ result ] = matrixMultiplication( A, B )
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
    result = zeros(9, 1);

    result(1) = A(1) * B(1) + A(2) * B(4) + A(3) * B(7);
    result(2) = A(1) * B(2) + A(2) * B(5) + A(3) * B(8);
    result(3) = A(1) * B(3) + A(2) * B(6) + A(3) * B(9);

    result(4) = A(4) * B(1) + A(5) * B(4) + A(6) * B(7);
    result(5) = A(4) * B(2) + A(5) * B(5) + A(6) * B(8);
    result(6) = A(4) * B(3) + A(5) * B(6) + A(6) * B(9);

    result(7) = A(7) * B(1) + A(8) * B(4) + A(9) * B(7);
    result(8) = A(7) * B(2) + A(8) * B(5) + A(9) * B(8);
    result(9) = A(7) * B(3) + A(8) * B(6) + A(9) * B(9);
end

