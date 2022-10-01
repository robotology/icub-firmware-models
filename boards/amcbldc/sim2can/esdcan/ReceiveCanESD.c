
#define S_FUNCTION_NAME ReceiveCanESD
#define S_FUNCTION_LEVEL 2


#define ESDCAN_IS_CONNECTED 

#define SAMPLE_TIME_0        INHERITED_SAMPLE_TIME
#define NUM_DISC_STATES      0
#define DISC_STATES_IC       [0]
#define NUM_CONT_STATES      0
#define CONT_STATES_IC       [0]

#define SFUNWIZ_GENERATE_TLC 1
#define SOURCEFILES "__SFB__"
#define PANELINDEX           6
#define USE_SIMSTRUCT        0
#define SHOW_COMPILE_STEPS   0                   
#define CREATE_DEBUG_MEXFILE 0
#define SAVE_CODE_ONLY       0
#define SFUNWIZ_REVISION     3.0
/* %%%-SFUNWIZ_defines_Changes_END --- EDIT HERE TO _BEGIN */
/*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
#include "simstruc.h"
#include "ntcan.h"

#define         NUMBER_OF_ARGS      (7)
#define         CAN_BAUDRATE        ssGetSFcnParam(S,0)
#define         NET_ID              ssGetSFcnParam(S,1)
#define         TX_QUEUE_SIZE       ssGetSFcnParam(S,2)
#define         RX_QUEUE_SIZE       ssGetSFcnParam(S,3)
#define         TX_TIMEOUT          ssGetSFcnParam(S,4)
#define         RX_TIMEOUT          ssGetSFcnParam(S,5)
#define IS_PARAM_DOUBLE(pVal) (mxIsNumeric(pVal) && !mxIsLogical(pVal) &&\
!mxIsEmpty(pVal) && !mxIsSparse(pVal) && !mxIsComplex(pVal) && mxIsDouble(pVal))


 NTCAN_HANDLE  m_h0=NULL;
 CMSG rx_message[40];
 long ret;  
 int x=0;
/*====================*
 * S-function methods *
 *====================*/
#define MDL_CHECK_PARAMETERS
 #if defined(MDL_CHECK_PARAMETERS) && defined(MATLAB_MEX_FILE)  //
   /* Function: mdlCheckParameters =============================================
     * Abstract:
     *    Validate our parameters to verify they are okay.
     */
    static void mdlCheckParameters(SimStruct *S)
    {
     int i=0;
     /* All parameters must match the S-function Builder Dialog */
     
     for(i=0; i<NUMBER_OF_ARGS; i++)
	 {
        if(mxIsEmpty(ssGetSFcnParam(S,i)))
        {
//             char strErr[100];
//             char paramName[40];
//             ssGetSFcnParamName(S, i, paramName);
//             strErr=sprintf("The param %s is empty!", paramName);
            ssSetErrorStatus(S,"A param is empty");
        }
     }
	return;
    }
 #endif /* MDL_CHECK_PARAMETERS */
/* Function: mdlInitializeSizes ===============================================
 * Abstract:
 *   Setup sizes of the various vectors.
 */
static void mdlInitializeSizes(SimStruct *S)
{
    int m_net;
    //IMPORTANT: It is necessary get a real and then cat it to int
    const real_T *m_txbufsize = mxGetData(TX_QUEUE_SIZE);
    int m_txbufsize_int = (int)*m_txbufsize;

    const real_T *m_rxbufsize = mxGetData(RX_QUEUE_SIZE);
    int m_rxbufsize_int = (int)*m_rxbufsize;

    const real_T *m_txtout    = mxGetData(TX_TIMEOUT);
    int m_txtout_int = (int)*m_txtout;

    const real_T *m_rxtout    = mxGetData(RX_TIMEOUT);
    int m_rxtout_int = (int)*m_rxtout;


    unsigned long m_mode=0; //Use deafult behaviour (FIFO mode)
    int m_baudrate;
    const int16_T  *baudrate  = mxGetData(CAN_BAUDRATE); 
    int_T i,j=0;
  //  DECL_AND_INIT_DIMSINFO(inputDimsInfo);
  //  DECL_AND_INIT_DIMSINFO(outputDimsInfo);
    ssSetNumSFcnParams(S, NUMBER_OF_ARGS);  /* Number of expected parameters */
      #if defined(MATLAB_MEX_FILE)
	if (ssGetNumSFcnParams(S) == ssGetSFcnParamsCount(S)) 
    {
     //   mdlCheckParameters(S);
        if (ssGetErrorStatus(S) != NULL) 
        {
            return;
        }
     } 
     else 
     {
        return; /* Parameter mismatch will be reported by Simulink */
	 }
      #endif
    
    ssSetNumContStates(S, 0);
    ssSetNumDiscStates(S, 0);
    ssSetNumInputPorts(S, 0);
    ssSetNumOutputPorts(S, 3);

    ssSetOutputPortWidth(S, 0, 8);
    ssSetOutputPortDataType(S, 0, SS_DOUBLE);

    ssSetOutputPortWidth(S, 1, 1);
    ssSetOutputPortDataType(S, 1, SS_DOUBLE);

    ssSetOutputPortWidth(S, 2, 1);
    ssSetOutputPortDataType(S, 2, SS_BOOLEAN);

    
    ssSetNumSampleTimes(S, 1);
    ssSetNumRWork(S, 0);
    ssSetNumIWork(S, 0);
    ssSetNumPWork(S, 0);
    ssSetNumModes(S, 0);
    ssSetNumNonsampledZCs(S, 0);
   
    for (i=0;i<NUMBER_OF_ARGS;i++) 
    {
       ssSetSFcnParamNotTunable(S,i);
    }

    /* Take care when specifying exception free code - see sfuntmpl_doc.c */
    ssSetOptions(S, (SS_OPTION_EXCEPTION_FREE_CODE |
                  //   SS_OPTION_USE_TLC_WITH_ACCELERATOR |
		     SS_OPTION_WORKS_WITH_CODE_REUSE));
    const real_T  *netid = mxGetData(NET_ID);
    m_net=(int) *netid;

    printf("m_txbufsize=%d, m_rxbufsize=%d, m_txtout=%d, m_rxtout=%d,  m_net=%d", m_txbufsize_int, m_rxbufsize_int, m_txtout_int, m_rxtout_int, m_net);

    #ifdef ESDCAN_IS_CONNECTED
    ret = canOpen(m_net, m_mode, m_txbufsize_int, m_rxbufsize_int, m_txtout_int, m_rxtout_int, &m_h0);
    #else
    printf("CanOpen(mnet=%d, m_mode=%d, m_txbufsize=%d, m_rxbufsize=%d, m_txtout=%d, m_rxtout=%d)", m_net, m_mode, m_txbufsize_int, m_rxbufsize_int, m_txtout_int, m_rxtout_int, m_net);
    ret=NTCAN_SUCCESS;
    #endif
    if(ret == NTCAN_SUCCESS)
    {
     x=1;
    }
    else
    {
        x=-1;
        //canClose(m_h0);
        char errorM[17] = "CanOpen failed: ";
        ssSetErrorStatus(S,"CanOpen failed");
        return;
    }
   m_baudrate=(int) *baudrate;
    #ifdef ESDCAN_IS_CONNECTED
    ret = canSetBaudrate(m_h0,m_baudrate);//canSetBaudrate(m_h0, z-1);
    #else
    printf("canSetBaudrate(m_baudrate=%d)", m_baudrate);
    ret=NTCAN_SUCCESS;
    #endif
    if(ret == NTCAN_SUCCESS)
    {
     x=1;
    }
    else
    {
        x=-1;
        #ifdef ESDCAN_IS_CONNECTED
        canClose(m_h0);
        #endif
        ssSetErrorStatus(S,"CANSetBaudrate failed");
        return;
    }

    /*Get ID list*/
    real_T *list = (real_T*) mxGetPr(ssGetSFcnParam(S,6));
    size_t  listSize = mxGetNumberOfElements(ssGetSFcnParam(S,6));


    ssPrintf("\n ID List (len=%d): ", listSize);
    int* id = (int*)malloc(listSize*sizeof(int));

    for(i=0; i< listSize; i++)
    {
        id[i]= (int)list[i];
        ssPrintf(" %f (%d)\n", list[i], id[i]);
    }

     ssPrintf("\n ");
     for (i=0;i<listSize;i++) 
     {
        #ifdef ESDCAN_IS_CONNECTED
        ret = canIdAdd(m_h0,id[i]);
        #else
        //printf("canIdAdd(id=%d)", id[i]);
        ret=NTCAN_SUCCESS;
        #endif
        if(ret == NTCAN_SUCCESS)
        {
            x=1;
        }
        else
        {
//             x=-1;
//             canClose(m_h0);
//             char err[100];
//             snprintf(err, sizeof(err), "CANIdAdd failed: %d", ret);
//             printf(err);
//             ssSetErrorStatus(S,err);
            printf("err=%d\n", ret);
            ssSetErrorStatus(S,"CanIdAdd error");
            
            return;   
        }
     }
  if (ret == NTCAN_INSUFFICIENT_RESOURCES)
  {
      #ifdef ESDCAN_IS_CONNECTED
     canClose(m_h0);
      #endif
  }

  //get memory in order to save the last received message
  ssSetNumIWork(S, 9); //id+ 8 byte of payload
  ssSetNumDWork(S, 1); //this variable is used to indicate if a new message has been received:
                       //its values can be 0 or 1 and when it changes value means a new message has been received.
  ssSetDWorkWidth(S, 0, 1);
  ssSetDWorkDataType(S, 0, SS_BOOLEAN);
 //ref: https://it.mathworks.com/help/simulink/sfg/how-to-use-dwork-vectors.html

 // cleanup memory
 free(id);
}

#if defined(MATLAB_MEX_FILE)
#define MDL_SET_INPUT_PORT_DIMENSION_INFO
static void mdlSetInputPortDimensionInfo(SimStruct        *S, 
                                         int_T            port,
                                         const DimsInfo_T *dimsInfo)
{
    if(!ssSetInputPortDimensionInfo(S, port, dimsInfo)) return;
}
#endif

#define MDL_SET_OUTPUT_PORT_DIMENSION_INFO
#if defined(MDL_SET_OUTPUT_PORT_DIMENSION_INFO)
static void mdlSetOutputPortDimensionInfo(SimStruct        *S, 
                                          int_T            port, 
                                          const DimsInfo_T *dimsInfo)
{
 if (!ssSetOutputPortDimensionInfo(S, port, dimsInfo)) return;
}
#endif

/* Function: mdlInitializeSampleTimes =========================================
 * Abstract:
 *    Specifiy  the sample time.
 */
static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetSampleTime(S, 0, SAMPLE_TIME_0);
    ssSetOffsetTime(S, 0, 0.0);
}

#define MDL_SET_INPUT_PORT_DATA_TYPE
static void mdlSetInputPortDataType(SimStruct *S, int port, DTypeId dType)
{
    ssSetInputPortDataType( S, 0, dType);
    
}

#define MDL_SET_DEFAULT_PORT_DATA_TYPES
static void mdlSetDefaultPortDataTypes(SimStruct *S)
{
  ssSetInputPortDataType( S, 0, SS_DOUBLE);
}

/* Function: mdlOutputs =======================================================
 * here all work vector should be initialized
*/
static void mdlStart(SimStruct *S)
{
    bool *newMsg = (bool*) ssGetDWork(S,0);

    /*  Initialize the first DWork vector */
    newMsg=false;
}
/* Function: mdlOutputs =======================================================
 *
*/
static void mdlOutputs(SimStruct *S, int_T tid)
{
    real_T        *output_message;
    real_T        *output_id;
    boolean_T     *output_newMsg;
    
    int i=0;
    int d=0;
    
    output_message=ssGetOutputPortRealSignal(S,0);
    output_id=ssGetOutputPortRealSignal(S,1);
    output_newMsg=(boolean_T *) ssGetOutputPortSignal(S, 2);

    for (d=0;d<8;d++)
    {
        output_message[d]=(int_T) -1; 
    }
    output_id[0] = -1;

    int32_T message_len=1;

    #ifdef ESDCAN_IS_CONNECTED
    ret =canTake(m_h0, rx_message, &message_len);
    if(ret != NTCAN_SUCCESS)
        return; //error
    if(message_len==0)  //no message received
    {
        int_T *lastMsg=ssGetIWork(S);
        for (d=0;d<8;d++)
        {
            output_message[d]=lastMsg[d+1];
        }
        output_id[0]=(double) lastMsg[0];
        return;
    }
      

    *output_newMsg= (!(*output_newMsg));
    for (i=0;i<message_len;i++)
    {
        for (d=0;d<8;d++)
        {
            output_message[d]=(int_T) rx_message[i].data[d]; 
        }
        output_id[0]=(double) rx_message[i].id;
    }

    //save the last message
    int index_last=0;
    int_T *lastMsg=ssGetIWork(S);

    lastMsg[0]=output_id[index_last];
    for (d=0;d<8;d++)
    {
        lastMsg[d+1]= output_message[d];
    }

    #endif
    


}

// #define MDL_UPDATE
// /* Function: mdlUpdate ========================================================
//  * Abstract:
//  *      Every time through the simulation loop, update the
//  *      transfer function coefficients. Here we update the oldest bank.
//  */
// static void mdlUpdate(SimStruct *S, int_T tid)
// {
//     UNUSED_ARG(tid); /* not used in single tasking mode */
//     int_T *lastMsg=ssGetIWork(S);
//     lastMsg[0]=ssGetOutputPortRealSignal(S,1);
//     int d;
//     for (d=0;d<8;d++)
//     {
//         lastMsg[d+1]=(int_T) ssGetOutputPortRealSignal(S,0)[d];
//     }
// }


/* Function: mdlTerminate =====================================================
 * Abstract:
 *    In this function, you should perform any actions that are necessary
 *    at the termination of a simulation.  For example, if memory was
 *    allocated in mdlStart, this is the place to free it.
 */
static void mdlTerminate(SimStruct *S)
{
    #ifdef ESDCAN_IS_CONNECTED
    canClose(m_h0);
    #endif
    return;
}

#ifdef  MATLAB_MEX_FILE    /* Is this file being compiled as a MEX-file? */
#include "simulink.c"      /* MEX-file interface mechanism */
#else
#include "cg_sfun.h"       /* Code generation registration function */
#endif


