classdef EstimationVelocityModes < Simulink.IntEnumType
    enumeration
        Disabled(0)
        MovingAverage(1)
        LeastSquares(2)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end

