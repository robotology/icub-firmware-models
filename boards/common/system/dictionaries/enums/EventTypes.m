classdef EventTypes < Simulink.IntEnumType
    enumeration
None(0)
SetLimit(1)
SetControlMode(2)
SetMotorConfig(3)
SetPid(4)
SetTarget(5)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end

