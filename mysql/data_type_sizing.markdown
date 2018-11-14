## Data Type Sizing

If you are used to writing SQL, you are likely familiar with specifying sizes
for your data types. For example, when creating a column of type `VARCHAR` with
a string with a maximum length of `25`, the syntax would look like the following:

```SQL
VARCHAR(25)
```

However, the values between the parenthesis are not always as straight forward,
and can be type, or even database engine specific. In this memory dump, I'll focus
on MySQL's InnoDB engine.

### Lengths



### Storage

|   TYPE   | Storage (Bytes) |
|----------|---------------- |
|  `TINYINT`      |          1 |
|  `SMALLINT`     |          2 |
|  `MEDIUMINT`    |          3 |
|  `INT`/`INTEGER`|          4 |
|  `BIGINT`       |          8 |

### Values

Below are values that each integer-based type can hold, separated 
by whether the type is signed or unsigned.

##### Signed

|   Type   | Minimum | Maximum |
|----------|---------|---------|
|  `TINYINT`      |-128|127|
|  `SMALLINT`     |-32768|32767|
|  `MEDIUMINT`    |-8388608|8388607|
|  `INT`/`INTEGER`  |-2147483648|2147483647|
|  `BIGINT`       |-9223372036854775808|9223372036854775807|

##### Unsigned

|   Type   | Minimum | Maximum |
|----------|---------|---------|
|  `TINYINT`      |0|255|
|  `SMALLINT`     |0|65535|
|  `MEDIUMINT`    |0|16777215|
|  `INT`/`INTEGER`  |0|4294967295|
|  `BIGINT`       |0|18446744073709551615|
