function [] = testSensorFusion(filename)

    if ~exist('filename','var')
        filename = 'IOB-6-Inertial-20150701-161057.001.csv';
    end

    % Timestamp
    [ttimestamp] = csvimport( filename, 'columns', 3,'noHeader', true );
    timestamp = cellArray2DoubleArray(ttimestamp);

    % Accelerometer
    [tAccX, tAccY, tAccZ] = csvimport( filename, 'columns', [4, 5, 6],'noHeader', true );

    AccX = cellArray2DoubleArray(tAccX);
    AccY = cellArray2DoubleArray(tAccY);
    AccZ = cellArray2DoubleArray(tAccZ);
    Acc = [AccX, AccY, AccZ];

    % Magnetometer
    [tMagnX, tMagnY, tMagnZ] = csvimport( filename, 'columns', [10, 11, 12],'noHeader', true );

    MagnX = cellArray2DoubleArray(tMagnX);
    MagnY = cellArray2DoubleArray(tMagnY);
    MagnZ = cellArray2DoubleArray(tMagnZ);
    Magn = [MagnX, MagnY, MagnZ];

    % Gyroscope
    [tGyroX, tGyroY, tGyroZ] = csvimport( filename, 'columns', [16, 17, 18],'noHeader', true ); 

    GyroX = cellArray2DoubleArray(tGyroX);
    GyroY = cellArray2DoubleArray(tGyroY);
    GyroZ = cellArray2DoubleArray(tGyroZ);
    Gyro = [GyroX, GyroY, GyroZ];

    % Sensor fusion
    [ fusedOrientation ] = fuseSensors( Acc, Magn, Gyro, timestamp );

    numorientation = size(fusedOrientation, 1);
    time = (1:numorientation)';

    figure('name', 'Azimuth');
    plot(time, fusedOrientation(:, 1));

    figure('name', 'Pitch');
    plot(time, fusedOrientation(:, 2));

    figure('name', 'Roll');
    plot(time, fusedOrientation(:, 3));
end
