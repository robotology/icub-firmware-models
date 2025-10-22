% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

classdef MCOPC < Simulink.IntEnumType
    enumeration
        Set_Parameter(0x01)
        Set(0x05)
        Set_Control_Mode(0x09)
        Set_Current_Limit(0x48)
        Set_Current_PID(0x65)
        Set_Velocity_PID(0x69)
        Set_Position_PID(0x52)
        Set_Motor_Config(0x77)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end
