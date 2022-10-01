# Using Simulink to operate ESD Can Interfaces

MATLAB supports the CAN protocol natively only for a [select list of vendors](https://it.mathworks.com/hardware-support/can-bus-software.html). To support ESD Can interfaces such as these:

![esd-can-interface](./assets/esd-can-interface.png)

Custom Simulink blocks have been created from C code. Until now, they have only been tested on Windows (Since we use [CANReal](https://esd.eu/en/products/canreal) for debugging which only supports Windows).

## How to use the blocks

The first thing to do is to compile the C code into a `.mexw64` file. This is done by typing in the MATLAB command window the following:

```MATLAB
mex('ReceiveCanESD.c','ntcan.lib')
mex('SendCanESD.c','ntcan.lib')
```

You should now see new files in the directory with the extension `.mexw64` (on Windows).

Make sure the `.c` files as well as the `ntcan.lib` file are part of your path. (If you opened the `.prj` file this should be handled automatically).

Now you can use the `receiverBlock.slx` and `senderBlock.slx` blocks in your Simulink model.

## Send Block

The send block looks like this:

![send-block](./assets/send-block.png)

Before using it, you must double click the block to open the mask and set the correct baudrate, network, queue sizes and timeout. The CAN Network can be set through the CAN interface's drivers.

Setting the wrong parameters will result in errors at runtime.

The `Message` input is an array of same length as the parameter in the mask, while `ID` is a number. The `Stream ON/OFF` input allows for continuous streaming of messages at the set baudrate. To enable this keep this input at `1`. The CAN box can also send individual messages if the `Send Single Msg` input changes from `0` to `1`. A recommended use case is to connect `Stream ON/OFF` to a Toggle Switch and `Send Single Msg` to a Push Button. as seen below:

![toggle-push](./assets/toggle-push.png)

The output of the block is the `status` of the CAN interface. 

## Receive Block

The receive block looks like this:

![receive-block](./assets/receive-block.png)

Before using it, you must double click the block to open the mask and set the correct baudrate, network, queue sizes and timeout. The CAN Network can be set through the CAN interface's drivers.

It is also possible to filter which IDs to receive messages from. These are specified as an array as seen in the image above. 

Setting the wrong parameters will result in errors at runtime.

The `Message` output is an array of length 8. The `ID` of the message is also sent as output. The `Message Received` output toggles between `TRUE` and `FALSE` when a new message is received. It can be plotted or connected to a `LAMP` to know when there have been new messages.


