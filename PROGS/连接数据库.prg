SELECT 0
USE ..\DATA\sys1.DBF
********************************************************
* 数据库密码解密，（一半是程式密码，另一半用户密码）
keyss1 = ALLTRIM(txts1)
USE 
IF LEN(keyss1) > 0
TempStr1=''
For i=1 To Len(Trim(keyss1))
	TempChr1=Bitxor(Asc(Substr(Trim(keyss1),i,1)),73)
	TempStr1=TempStr1+Chr(TempChr1)
ENDFOR
   ELSE
   TempStr1 = ''
ENDIF 
********************************************************


SQLSETPROP(0,"DispLogin" ,3) && 不打开ODBC连接界面
* CON=SQLSTRINGCONNECT("driver=SQL Server;Server=192.168.1.246;Uid=wk666;pwd=3b7d29akfq93lgs8;database=hzxlydb")
*   csqlserver  = '192.168.1.246'
* 设定连接串
* TempStr1 = 'as3781678#'+TempStr1
 TempStr1 = '3b7d29akfq93lgs8'+TempStr1

linkdb1 = 'driver=SQL Server;Server='
  linkdb1 = linkdb1+csqlserver
  linkdb1 = linkdb1+';Uid=user888;pwd=&TempStr1;database=hzxlydb'
lnHandle=SQLSTRINGCONNECT(linkdb1)

*?lnHandle

* 得到con连接成功的句柄后，便可对要连接的数据库里的数据表进行操作 
*   =SqlExec(lnHandle,"Select * From 工艺基础父表","TmpTableName")  
*   BROWSE
*   USE

