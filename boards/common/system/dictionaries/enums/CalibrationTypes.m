classdef CalibrationTypes < Simulink.IntEnumType
    enumeration
        None(0)
        Search_Index(1)
        Full_Calibration(2) 
    end
    methods (Static = true)
        function retVal = addClassNameToEnumNames()
            retVal = true;
        end
    end
end