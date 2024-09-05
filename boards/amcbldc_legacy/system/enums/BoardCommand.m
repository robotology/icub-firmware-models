% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

classdef BoardCommand < Simulink.IntEnumType
    enumeration
        ForceIdle(0)
        SetIdle(1)
        SetPosition(2)
        SetCurrent(3)
        SetVelocity(4)
        SetVoltage(5)
        SetTorque(6)
        Reset(7)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end