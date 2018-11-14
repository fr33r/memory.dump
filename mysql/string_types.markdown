## MySQL String Types

Frequently we want to store character data. However, when it comes time to write a `CREATE TABLE` or `ALTER TABLE` statement to introduce the column definition, several decisions have to be made:

-	Which data type do I use?
-	What length do I specify?
-	What character set should I use?
-	How much space could my column utilize?

In my professional career, I have noticed that many of the decisions about which data type to use, the length of that type, as well as the character set used for it are a bit arbitrary or misguided. In a quest to unravel the mysteries, I found answers to the common questions faced when dealing with character data.

**In particular, this article was written to address these questions in the context of MySQL. In particular, all snippets and examples were created using the following MySQL version: Server version: 5.7.16 MySQL Community Server (GPL)**

### What character set should I use?

Some requirements of the application that will be utilizing MySQL as a data store may warrent the need for a specific character set. For example, if there was a requirement for supporting the use of emojis in text fields, the `uft8mb4` would be a good choice. However, I have found that typically there are no such requirements, and choosing a character set turns more into a guessing game.

I am going to focus on one aspect of character sets when making the decision: the **maximum size** a character in character set could utilize. Why? It turns out that information will serve as input when deciding a length for our data type for a column, as well determine how much space our column could potentially utilize.

So what character sets are there? How can I determine how the maximum size a single character may use for each character set? Turns out there multiple ways of retrieving this information. One of which is entering [`SHOW CHARACTER SET;`](https://dev.mysql.com/doc/refman/5.7/en/show-character-set.html). Another way is issuing a `SELECT` statement on the [`CHARACTER_SETS`](https://dev.mysql.com/doc/refman/5.7/en/character-sets-table.html) table located in the `INFORMATION_SCHEMA` schema.

```
mysql> SHOW CHARACTER SET;
+----------+---------------------------------+---------------------+--------+
| Charset  | Description                     | Default collation   | Maxlen |
+----------+---------------------------------+---------------------+--------+
| big5     | Big5 Traditional Chinese        | big5_chinese_ci     |      2 |
| dec8     | DEC West European               | dec8_swedish_ci     |      1 |
| cp850    | DOS West European               | cp850_general_ci    |      1 |
| hp8      | HP West European                | hp8_english_ci      |      1 |
| koi8r    | KOI8-R Relcom Russian           | koi8r_general_ci    |      1 |
| latin1   | cp1252 West European            | latin1_swedish_ci   |      1 |
| latin2   | ISO 8859-2 Central European     | latin2_general_ci   |      1 |
| swe7     | 7bit Swedish                    | swe7_swedish_ci     |      1 |
| ascii    | US ASCII                        | ascii_general_ci    |      1 |
| ujis     | EUC-JP Japanese                 | ujis_japanese_ci    |      3 |
| sjis     | Shift-JIS Japanese              | sjis_japanese_ci    |      2 |
| hebrew   | ISO 8859-8 Hebrew               | hebrew_general_ci   |      1 |
| tis620   | TIS620 Thai                     | tis620_thai_ci      |      1 |
| euckr    | EUC-KR Korean                   | euckr_korean_ci     |      2 |
| koi8u    | KOI8-U Ukrainian                | koi8u_general_ci    |      1 |
| gb2312   | GB2312 Simplified Chinese       | gb2312_chinese_ci   |      2 |
| greek    | ISO 8859-7 Greek                | greek_general_ci    |      1 |
| cp1250   | Windows Central European        | cp1250_general_ci   |      1 |
| gbk      | GBK Simplified Chinese          | gbk_chinese_ci      |      2 |
| latin5   | ISO 8859-9 Turkish              | latin5_turkish_ci   |      1 |
| armscii8 | ARMSCII-8 Armenian              | armscii8_general_ci |      1 |
| utf8     | UTF-8 Unicode                   | utf8_general_ci     |      3 |
| ucs2     | UCS-2 Unicode                   | ucs2_general_ci     |      2 |
| cp866    | DOS Russian                     | cp866_general_ci    |      1 |
| keybcs2  | DOS Kamenicky Czech-Slovak      | keybcs2_general_ci  |      1 |
| macce    | Mac Central European            | macce_general_ci    |      1 |
| macroman | Mac West European               | macroman_general_ci |      1 |
| cp852    | DOS Central European            | cp852_general_ci    |      1 |
| latin7   | ISO 8859-13 Baltic              | latin7_general_ci   |      1 |
| utf8mb4  | UTF-8 Unicode                   | utf8mb4_general_ci  |      4 |
| cp1251   | Windows Cyrillic                | cp1251_general_ci   |      1 |
| utf16    | UTF-16 Unicode                  | utf16_general_ci    |      4 |
| utf16le  | UTF-16LE Unicode                | utf16le_general_ci  |      4 |
| cp1256   | Windows Arabic                  | cp1256_general_ci   |      1 |
| cp1257   | Windows Baltic                  | cp1257_general_ci   |      1 |
| utf32    | UTF-32 Unicode                  | utf32_general_ci    |      4 |
| binary   | Binary pseudo charset           | binary              |      1 |
| geostd8  | GEOSTD8 Georgian                | geostd8_general_ci  |      1 |
| cp932    | SJIS for Windows Japanese       | cp932_japanese_ci   |      2 |
| eucjpms  | UJIS for Windows Japanese       | eucjpms_japanese_ci |      3 |
| gb18030  | China National Standard GB18030 | gb18030_chinese_ci  |      4 |
+----------+---------------------------------+---------------------+--------+
41 rows in set (0.01 sec)

```
```
mysql> SELECT * FROM INFORMATION_SCHEMA.CHARACTER_SETS;
+--------------------+----------------------+---------------------------------+--------+
| CHARACTER_SET_NAME | DEFAULT_COLLATE_NAME | DESCRIPTION                     | MAXLEN |
+--------------------+----------------------+---------------------------------+--------+
| big5               | big5_chinese_ci      | Big5 Traditional Chinese        |      2 |
| dec8               | dec8_swedish_ci      | DEC West European               |      1 |
| cp850              | cp850_general_ci     | DOS West European               |      1 |
| hp8                | hp8_english_ci       | HP West European                |      1 |
| koi8r              | koi8r_general_ci     | KOI8-R Relcom Russian           |      1 |
| latin1             | latin1_swedish_ci    | cp1252 West European            |      1 |
| latin2             | latin2_general_ci    | ISO 8859-2 Central European     |      1 |
| swe7               | swe7_swedish_ci      | 7bit Swedish                    |      1 |
| ascii              | ascii_general_ci     | US ASCII                        |      1 |
| ujis               | ujis_japanese_ci     | EUC-JP Japanese                 |      3 |
| sjis               | sjis_japanese_ci     | Shift-JIS Japanese              |      2 |
| hebrew             | hebrew_general_ci    | ISO 8859-8 Hebrew               |      1 |
| tis620             | tis620_thai_ci       | TIS620 Thai                     |      1 |
| euckr              | euckr_korean_ci      | EUC-KR Korean                   |      2 |
| koi8u              | koi8u_general_ci     | KOI8-U Ukrainian                |      1 |
| gb2312             | gb2312_chinese_ci    | GB2312 Simplified Chinese       |      2 |
| greek              | greek_general_ci     | ISO 8859-7 Greek                |      1 |
| cp1250             | cp1250_general_ci    | Windows Central European        |      1 |
| gbk                | gbk_chinese_ci       | GBK Simplified Chinese          |      2 |
| latin5             | latin5_turkish_ci    | ISO 8859-9 Turkish              |      1 |
| armscii8           | armscii8_general_ci  | ARMSCII-8 Armenian              |      1 |
| utf8               | utf8_general_ci      | UTF-8 Unicode                   |      3 |
| ucs2               | ucs2_general_ci      | UCS-2 Unicode                   |      2 |
| cp866              | cp866_general_ci     | DOS Russian                     |      1 |
| keybcs2            | keybcs2_general_ci   | DOS Kamenicky Czech-Slovak      |      1 |
| macce              | macce_general_ci     | Mac Central European            |      1 |
| macroman           | macroman_general_ci  | Mac West European               |      1 |
| cp852              | cp852_general_ci     | DOS Central European            |      1 |
| latin7             | latin7_general_ci    | ISO 8859-13 Baltic              |      1 |
| utf8mb4            | utf8mb4_general_ci   | UTF-8 Unicode                   |      4 |
| cp1251             | cp1251_general_ci    | Windows Cyrillic                |      1 |
| utf16              | utf16_general_ci     | UTF-16 Unicode                  |      4 |
| utf16le            | utf16le_general_ci   | UTF-16LE Unicode                |      4 |
| cp1256             | cp1256_general_ci    | Windows Arabic                  |      1 |
| cp1257             | cp1257_general_ci    | Windows Baltic                  |      1 |
| utf32              | utf32_general_ci     | UTF-32 Unicode                  |      4 |
| binary             | binary               | Binary pseudo charset           |      1 |
| geostd8            | geostd8_general_ci   | GEOSTD8 Georgian                |      1 |
| cp932              | cp932_japanese_ci    | SJIS for Windows Japanese       |      2 |
| eucjpms            | eucjpms_japanese_ci  | UJIS for Windows Japanese       |      3 |
| gb18030            | gb18030_chinese_ci   | China National Standard GB18030 |      4 |
+--------------------+----------------------+---------------------------------+--------+
41 rows in set (0.00 sec)
```

All potential application requirements aside (include requirements about language support), there are certainly benefits from making use of a character set that utilizes less bytes per character. As the output shown above communicates, some character sets have the potentialy of taking up 2, 3, or even four times more space than others (per character!), which can have a significant impact on the amount of overall space used.

If you don't have any particular application requirement in regard to globalization or emoji support, I would suggest sticking with the default character set. You can see what the default character set is for a particular schema (database) either by examining the value of the `@@character_set_database` variable, or by issuing a `SELECT` statement on the `SCHEMATA` table in the `INFORMATION_SCHEMA` schema.

```
mysql> SELECT @@character_set_database;
+--------------------------+
| @@character_set_database |
+--------------------------+
| latin1                   |
+--------------------------+
1 row in set (0.00 sec)
```

```
mysql> SELECT DEFAULT_CHARACTER_SET_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '<SCHEMA NAME HERE>';
+----------------------------+
| DEFAULT_CHARACTER_SET_NAME |
+----------------------------+
| latin1                     |
+----------------------------+
1 row in set (0.00 sec)
```

The `latin1` character set is a solid choice, since it makes use of only one byte per character.

### What length do I specify?

In my experience, the question of which **length** to use for a particular character-based data type has been answered most arbitrarily. I have stumbled upon variable length data types (such as `VARCHAR`) that have been given unjustifiably high lengths, lengths that appear to follow some homebrew offset scheme where each length is divisable evenly by `10`, as well lengths that appear to be powers of two (such as `256`, `512`, etc.). I have even witnessed columns being too small for the data being strored in them, causing the data to be truncated. In all of these situations there was no documentation to be found as to why these lengths were chosen, and any tribal knowledge that once existed became muddled as new engineers joining the team attempted to follow what they thought was an existing pattern.

The two major character-based data types are `VARCHAR` and `CHAR`. The following is a breakdown of significat information that plays a role in choosing the length for these two types:

`VARCHAR`
- Uses 1 extra byte to record it's value's length if the columns maximum length is 255 bytes or less, or two bytes if it exceeds 255 bytes.

`CHAR`
- MySQL always allocates the space necessary to hold the length specified, since `CHAR` is a fixed-length character-based data type.

When determining the appropriate size for a variable-length character-based data type such as `VARCHAR`, it beneficial to know the maximum length that can be supported with the chosen character set before incurring the storage cost of an additional byte when the maximum length of data exceeds 255 bytes. This number can be determined using the following:

`floor(255/(max bytes per character)) = maximum length before imposing an additional byte.`

For convenience, the following table has the maximum length supported before exceeding 255 bytes for the distinct `MAXLEN` values for the character sets on my MySQL instance.

| Bytes per character | Max length <= 255 bytes |
|---------------------|-------------------------|
|                   1 |                     255 |
|                   2 |                     127 |
|                   3 |                      85 |
|                   4 |                      63 |

This demonstrates that there could be a noteable savings on storage if the character data being stored is less then or equal `63` character long, regardless of which character set is being used. It also shows that at most, if a character set with a single byte per character is being used, that character data up to a length of `255` could be stored without incurring the cost of an additional byte.


### Which data type do I use?

#### Why use `VARCHAR`?

- Can require a significant amount less storage space than fixed-length character-based data types such as `CHAR`, because it only utilizes as much space needed.
- Helps performance because they save storage space.
- Generally a good choice when the maximum size of the data in the column is much larger then the average length.
- A solid choice when using complex character sets where each character set uses a variable number of bytes of storage (such as UTF-8).

#### Why use `CHAR`?

- Useful when you want to store really short strings.
- A good candidate if the values of the column are all nearly the same length.
- Could potentially be more space effecient than variable-length character-based data types such as `VARCHAR` when given a length of `1`.

In my experience, `VARCHAR` is going to be more the more suitable choice. The data being stored is likely to vary significantly in size. In addition, it is more likely that the maximum length of data stored in a column is significantly larger than the average. A great example would be a textbox entry for listing dietary restrictions. On average, a user of the application may not specify any dietary restrictions, while the maximum could contain several lines describing every dietary restriction a person has.

I have also personally seen the wrath of whitespace padding when using `CHAR` even for data that had similar data lengths, leading to bugs with user impact. I have found that often times the nature of data that is consitently the same length are used as identifiers or hashes, which often have use cases of comparisons and equality. In my opinion the amount of application code required to ensure that these values have been trimmed appropriately so that adequate comparisons can be made is too large of a downside to support the usage of `CHAR` in these circumstances.

One situation that poses itself as a time to choose `CHAR` over `VARCHAR` is when the data for the column is only one character long. Here, a `CHAR` actually utilizes less space, since a `VARCHAR` datatype would need to leverage an additional byte to track the length of the data. More concretely, assuming a character set is used where the maximum number of bytes per character is `1` byte, a `CHAR(1)` would require `1` byte of storage where a `VARCHAR(1)` would require `2` bytes.
