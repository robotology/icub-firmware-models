% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

classdef BoardState < Simulink.IntEnumType
    enumeration
        NotConfigured(0)
        Configured(1)
        Fault(2)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end