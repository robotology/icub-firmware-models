% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

classdef CANClassTypes < Simulink.IntEnumType
    enumeration
        Motor_Control_Command(0)
        Motor_Control_Streaming(1)
        Analog_Sensors_Command(2)
        Skin_Sensor_Streaming(4)
        Inertial_Sensor_Streaming(5)
        Future_Use(6)
        Management_Bootloader(7)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end    
end
