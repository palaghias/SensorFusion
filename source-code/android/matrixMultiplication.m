function [ result ] = matrixMultiplication( A, B )
    
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

