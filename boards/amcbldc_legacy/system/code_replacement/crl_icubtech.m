function hLib = crl_icubtech


hLib = RTW.TflTable;
%---------- entry: RTW_MUTEX_INIT ----------- 
hEnt = RTW.TflCSemaphoreEntry;
hEnt.setTflCSemaphoreEntryParameters( ...
          'Key', 'RTW_MUTEX_INIT', ...
          'Priority', 100, ...
          'ImplementationName', 'rtw_mutex_init', ...
          'SaturationMode', 'RTW_SATURATE_ON_OVERFLOW', ...
          'ImplementationHeaderFile', 'rtw_mutex.h', ...
          'SideEffects', true);

% Conceptual Args

arg = hEnt.getTflArgFromString('y1','void');
arg.IOType = 'RTW_IO_OUTPUT';
hEnt.addConceptualArg(arg);

arg = hEnt.getTflArgFromString('u1','void');
hEnt.addConceptualArg(arg);

% Implementation Args 

arg = hEnt.getTflArgFromString('y1','double');
arg.IOType = 'RTW_IO_OUTPUT';
hEnt.Implementation.setReturn(arg); 

hLib.addEntry( hEnt ); 

%---------- entry: RTW_MUTEX_LOCK ----------- 
hEnt = RTW.TflCSemaphoreEntry;
hEnt.setTflCSemaphoreEntryParameters( ...
          'Key', 'RTW_MUTEX_LOCK', ...
          'Priority', 100, ...
          'ImplementationName', 'rtw_mutex_lock', ...
          'ImplementationHeaderFile', 'rtw_mutex.h', ...
          'SideEffects', true);

% Conceptual Args

arg = hEnt.getTflArgFromString('y1','void');
arg.IOType = 'RTW_IO_OUTPUT';
hEnt.addConceptualArg(arg);

arg = hEnt.getTflArgFromString('u1','void');
hEnt.addConceptualArg(arg);

% Implementation Args 

arg = hEnt.getTflArgFromString('y1','void');
arg.IOType = 'RTW_IO_OUTPUT';
hEnt.Implementation.setReturn(arg); 

hLib.addEntry( hEnt ); 

%---------- entry: RTW_MUTEX_UNLOCK ----------- 
hEnt = RTW.TflCSemaphoreEntry;
hEnt.setTflCSemaphoreEntryParameters( ...
          'Key', 'RTW_MUTEX_UNLOCK', ...
          'Priority', 100, ...
          'ImplementationName', 'rtw_mutex_unlock', ...
          'ImplementationHeaderFile', 'rtw_mutex.h', ...
          'SideEffects', true);

% Conceptual Args

arg = hEnt.getTflArgFromString('y1','void');
arg.IOType = 'RTW_IO_OUTPUT';
hEnt.addConceptualArg(arg);

arg = hEnt.getTflArgFromString('u1','void');
hEnt.addConceptualArg(arg);

% Implementation Args 

arg = hEnt.getTflArgFromString('y1','void');
arg.IOType = 'RTW_IO_OUTPUT';
hEnt.Implementation.setReturn(arg); 

hLib.addEntry( hEnt ); 

%---------- entry: RTW_MUTEX_DESTROY ----------- 
hEnt = RTW.TflCSemaphoreEntry;
hEnt.setTflCSemaphoreEntryParameters( ...
          'Key', 'RTW_MUTEX_DESTROY', ...
          'Priority', 100, ...
          'ImplementationName', 'rtw_mutex_destroy', ...
          'SaturationMode', 'RTW_SATURATE_ON_OVERFLOW', ...
          'ImplementationHeaderFile', 'rtw_mutex.h', ...
          'SideEffects', true);

% Conceptual Args

arg = hEnt.getTflArgFromString('y1','void');
arg.IOType = 'RTW_IO_OUTPUT';
hEnt.addConceptualArg(arg);

arg = hEnt.getTflArgFromString('u1','void');
hEnt.addConceptualArg(arg);

% Implementation Args 

arg = hEnt.getTflArgFromString('y1','void');
arg.IOType = 'RTW_IO_OUTPUT';
hEnt.Implementation.setReturn(arg); 

hLib.addEntry( hEnt ); 

