% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

classdef ControlModes < Simulink.IntEnumType
    enumeration
        NotConfigured(0)
        Idle(1)
        Position(2)
        PositionDirect(3)
        Current(4)
        Velocity(5)
        Voltage(6)
        Torque(7)
        HwFaultCM(8)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end    
end
