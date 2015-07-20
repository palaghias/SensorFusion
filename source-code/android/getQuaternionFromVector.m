function [ Q ] = getQuaternionFromVector( rv )
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

