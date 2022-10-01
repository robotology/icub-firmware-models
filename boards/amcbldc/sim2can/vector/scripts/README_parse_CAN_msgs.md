## How to use the Parse CAN Msgs Functions:

1. From **CAN Explorer** press `Export` to save your data in the workspace

![image](https://user-images.githubusercontent.com/31577366/178956268-15087142-e85c-4156-9a66-34ce084e388c.png)

2. Change the name of the variable inside the first command, to match the variable exported to the workspace:

![image](https://user-images.githubusercontent.com/31577366/178956707-f0cd7ecc-47b2-4c6e-8b52-84a2f9fa95f8.png)

3. Begin chaining the functions together to match your use case. Most functions require the ID to be a string instead of a number, so make sure to put your functions _after_ the `dec2hex` command, which makes this conversion.

## Available functions:

`filterByTime(table, start_time, stop_time)`

Returns a new table with only the messages between the start and stop time

`filterByID(table, [ID_list])`

Returns a new table with only the messages whose IDs are part of the input array

`filterByByte(table, byte_position, byte_value)`

Returns a new table with only the messages that contain the input value in the given byte position

`replaceID(table, old_ID, new_ID)`

Returns a new table where an ID is replaced by another number/text.

**Note:** Due to a Matlab limitation the new ID **must** be a 3 character string. 