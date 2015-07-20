function [ R, I ] = getRotationMatrix(gravity, geomagnetic )
% Computes the inclination matrix I as well as the rotation matrix R transforming a vector from the device coordinate system to the world's coordinate system which is defined as a direct orthonormal basis, where:
% X is defined as the vector product Y.Z (It is tangential to the ground at the device's current location and roughly points East).
% Y is tangential to the ground at the device's current location and points towards the magnetic North Pole.
% Z points towards the sky and is perpendicular to the ground.
% By definition:
% (0 0 g) = R * gravity (g = magnitude of gravity)
% (0 m 0) = I * R * geomagnetic (m = magnitude of geomagnetic field)
% R is the identity matrix when the device is aligned with the world's coordinate system, that is, when the device's X axis points toward East, the Y axis points to the North Pole and the device is facing the sky.
% I is a rotation matrix transforming the geomagnetic vector into the same coordinate space as gravity (the world's coordinate space). I is a simple rotation around the X axis. The inclination angle in radians can be computed with getInclination(()).
% Each matrix is returned either as a 3x3 or 4x4 row-major matrix depending on the length of the passed array:
% If the array length is 16:
%    /  M( 0)   M( 1)   M( 2)   M( 3)  \
%    |  M( 4)   M( 5)   M( 6)   M( 7)  |
%    |  M( 8)   M( 9)   M(10)   M(11)  |
%    \  M(12)   M(13)   M(14)   M(15)  /
% This matrix is ready to be used by OpenGL ES's glLoadMatrixf((), int).
% Note that because OpenGL matrices are column-major matrices you must transpose the matrix before using it. However, since the matrix is a rotation matrix, its transpose is also its inverse, conveniently, it is often the inverse of the rotation that is needed for rendering; it can therefore be used with OpenGL ES directly.
% Also note that the returned matrices always have this form:
%    /  M( 0)   M( 1)   M( 2)   0  \
%    |  M( 4)   M( 5)   M( 6)   0  |
%    |  M( 8)   M( 9)   M(10)   0  |
%    \      0       0       0   1  /
% If the array length is 9:
%    /  M( 0)   M( 1)   M( 2)  \
%    |  M( 3)   M( 4)   M( 5)  |
%    \  M( 6)   M( 7)   M( 8)  /
% The inverse of each matrix can be computed easily by taking its transpose.
% The matrices returned by this function are meaningful only when the device is not free-falling and it is not close to the magnetic north. If the device is accelerating, or placed into a strong magnetic field, the returned matrices may be inaccurate.
% Parameters:
% R is an array of 9 s holding the rotation matrix R when this function returns. R can be null.
% I is an array of 9 s holding the rotation matrix I when this function returns. I can be null.
% gravity is an array of 3 s containing the gravity vector expressed in the device's coordinate. You can simply use the values returned by a SensorEvent of a Sensor of type TYPE_ACCELEROMETER.
% geomagnetic is an array of 3 s containing the geomagnetic vector expressed in the device's coordinate. You can simply use the values returned by a SensorEvent of a Sensor of type TYPE_MAGNETIC_FIELD.
% Returns:
% true on success, false on failure (for instance, if the device is in free fall). On failure the output matrices are not modified.
% See also:
% getInclination(())
% getOrientation((),())
% remapCoordinateSystem((),int,int,())
%
%   Android 5.1.0
%

    % TODO: move this to native code for efficiency
     Ax = gravity(1);
     Ay = gravity(2);
     Az = gravity(3);
      Ex = geomagnetic(1);
      Ey = geomagnetic(2);
      Ez = geomagnetic(3);
     Hx = Ey*Az - Ez*Ay;
     Hy = Ez*Ax - Ex*Az;
     Hz = Ex*Ay - Ey*Ax;
      normH = sqrt(Hx*Hx + Hy*Hy + Hz*Hz);
    if (normH < 0.1) 
        % device is close to free fall (or in space?), or close to
        % magnetic north pole. Typical values are  > 100.
        disp('Device is close to free fall');
        return ;
    end

    invH = 1.0 / normH;
    Hx = Hx * invH;
    Hy = Hy * invH;
    Hz = Hz * invH;
    invA = 1.0 / sqrt(Ax*Ax + Ay*Ay + Az*Az);
    Ax = Ax * invA;
    Ay = Ay * invA;
    Az = Az * invA;
    Mx = Ay*Hz - Az*Hy;
    My = Az*Hx - Ax*Hz;
    Mz = Ax*Hy - Ay*Hx;
    
    R = zeros(9, 1);
    
    if (length(R) == 9) 
        R(1) = Hx;     R(2) = Hy;     R(3) = Hz;
        R(4) = Mx;     R(5) = My;     R(6) = Mz;
        R(7) = Ax;     R(8) = Ay;     R(9) = Az;
    elseif (length(R) == 16)
        %TODO: Fix the indices for matlab
        R(0)  = Hx;    R(1)  = Hy;    R(2)  = Hz;   R(3)  = 0;
        R(4)  = Mx;    R(5)  = My;    R(6)  = Mz;   R(7)  = 0;
        R(8)  = Ax;    R(9)  = Ay;    R(10) = Az;   R(11) = 0;
        R(12) = 0;     R(13) = 0;     R(14) = 0;    R(15) = 1;
    end
    
    
    I = zeros(9, 1);
    

    % compute the inclination matrix by projecting the geomagnetic
    % vector onto the Z (gravity) and X (horizontal component
    % of geomagnetic vector) axes.
      invE = 1.0 / sqrt(Ex*Ex + Ey*Ey + Ez*Ez);
      c = (Ex*Mx + Ey*My + Ez*Mz) * invE;
      s = (Ex*Ax + Ey*Ay + Ez*Az) * invE;
    if (length(I) == 9) 
        I(1) = 1;     I(2) = 0;     I(3) = 0;
        I(4) = 0;     I(5) = c;     I(6) = s;
        I(7) = 0;     I(8) =-s;     I(9) = c;
    elseif (length(I) == 16) 
        %TODO: Fix the indices for matlab
        I(0) = 1;     I(1) = 0;     I(2) = 0;
        I(4) = 0;     I(5) = c;     I(6) = s;
        I(8) = 0;     I(9) =-s;     I(10)= c;
        I(3) = 0; I(7) = 0; I(11) = 0; I(12) = 0; I(13) = 0; I(14) = 0;
        I(15) = 1;
    end
end

