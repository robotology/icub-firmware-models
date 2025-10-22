% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

classdef MCMotorParamsSet < uint8
    enumeration
        None       (0x00)
        Kbemf      (0x01)
        hall       (0x02)
        elect_vmax (0x03)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end
