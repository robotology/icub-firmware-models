% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

classdef MCStreaming < Simulink.IntEnumType
    enumeration
        Desired_Targets(0xF)
        FOC(0x0)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end
