* quit.prg
* DO ..\progs\删除数据源.prg
CLEAR DLLS
SET SAFETY OFF
* 断开所有数据连接
SQLDISCONNECT(0)

Close Data All
Close Table All
SELECT 0
USE ..\data\mmk1.dbf EXCLUSIVE
ZAP
USE

Quit

