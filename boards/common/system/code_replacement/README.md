# How to use the iCubTech code replacement

Simulink code generator allows to replace the generated functions with custom methods. The iCubTech Code Replacement Library (CRL) contains custom mutex handling functions that serve as replacement for the default Simulink ones used by the Embedded Coder.

Enabling the iCubTech CRL for a Simulink model requires simple steps:

1. In the Matlab command window, open the code replacement tool with `crtool`
2. Click on the directory icon called **Open Table**
3. Select the file `crl_icubtech.m`
4. On the middle pane you should now see the replacement functions
5. Press the green **Validate** button; if all functions are validated, you can close the window
6. In the command window, launch `sl_refresh_customizations` to refresh the index of replacement libraries

Now open your Simulink model:
1. On the **Modeling** tab, click **Settings**
2. On the **Code Generation > Interface** pane, for the **Code replacement libraries parameter**, click **Select**
3. Select the code replacement library Custom Function **iCubTech** and click OK.

## Mathworks References
[Custom Function Code Replacement](https://it.mathworks.com/help/ecoder/ug/custom-function-code-replacement.html)

[Code you can replace from Simulink Models](https://www.mathworks.com/help/ecoder/ug/code-you-can-replace-from-simulink-models.html)