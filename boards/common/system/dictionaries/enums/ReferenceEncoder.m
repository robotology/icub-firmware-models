classdef ReferenceEncoder < Simulink.IntEnumType
    enumeration
Motor(0)
Joint(1)
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end

