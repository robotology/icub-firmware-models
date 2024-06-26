classdef ControlModes < Simulink.IntEnumType
    enumeration
        NotConfigured(0)
        Idle(1)
        Position(2)
        PositionDirect(3)
        Current(4)
        Velocity(5)
        Voltage(6)
        HwFaultCM(7)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end

