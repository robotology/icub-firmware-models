% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

classdef MCControlModes < Simulink.IntEnumType
    enumeration
        Idle(0x00)
        OpenLoop(0x50)
        SpeedVoltage(0x0A)
        SpeedCurrent(0x0B)
        Current(0x06)
        NotConfigured(0xB0)
        HWFault(0xA0)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end
