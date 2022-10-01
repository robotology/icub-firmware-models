% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

classdef CANErrorTypes < Simulink.IntEnumType
    enumeration
        No_Error(0)
        Packet_Not4Us(1)
        Packet_Unrecognized(2)
        Packet_Malformed(3)
        Packet_MultiFunctionsDetected(4)
        Mode_Unrecognized(5)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end
