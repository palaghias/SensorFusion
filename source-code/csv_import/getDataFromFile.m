function [ x, y, z ] = getDataFromFile( filename, dataType )
%GETDATAFROMFILE This function retrieves data from a file
%
% filename: The name of the file.
% dataType: The type of data to retrieve 'Acc', 'Magn', 'Gyro', 'Grav'
%

    if strcmp(dataType, 'Acc') == 1
        disp(strcat('Importing accelerometer data from ', filename, ' ...')); 
        
        % Accelerometer
        [tAccX, tAccY, tAccZ] = csvimport( filename, 'columns', [4, 5, 6],'noHeader', true, 'uniformOutput', false, 'outputAsChar', false ); 

        x = cellArray2DoubleArray(tAccX);
        y = cellArray2DoubleArray(tAccY);
        z = cellArray2DoubleArray(tAccZ);
    elseif strcmp(dataType, 'Magn') == 1
        disp(strcat('Importing magnetometer data from ', filename, ' ...')); 
        
        % Magnetometer
        [tMagnX, tMagnY, tMagnZ] = csvimport( filename, 'columns', [10, 11, 12],'noHeader', true ); 

        x = cellArray2DoubleArray(tMagnX);
        y = cellArray2DoubleArray(tMagnY);
        z = cellArray2DoubleArray(tMagnZ);

    elseif strcmp(dataType, 'Gyro') == 1
        disp(strcat('Importing gyroscope data from ', filename, ' ...')); 
        
        % Gyroscope
        [tGyroX, tGyroY, tGyroZ] = csvimport( filename, 'columns', [16, 17, 18],'noHeader', true ); 

        x = cellArray2DoubleArray(tGyroX);
        y = cellArray2DoubleArray(tGyroY);
        z = cellArray2DoubleArray(tGyroZ);

    elseif strcmp(dataType, 'Grav') == 1
        disp(strcat('Importing gravity data from ', filename, ' ...')); 
        
        % Gravity
        [tGravX, tGravY, tGravZ] = csvimport( filename, 'columns', [22, 23, 24],'noHeader', true );

        x = cellArray2DoubleArray(tGravX);
        y = cellArray2DoubleArray(tGravY);
        z = cellArray2DoubleArray(tGravZ);
    else
            disp('Wrong input datatype');
    end
end

