% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

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
