* 程式名：删除数据源.prg
* 应用：用于关闭系统时调用


* 断开所有数据连接
SQLDISCONNECT(0)
* 删除数据源
DECLARE Integer SQLRemoveDSNFromIni IN odbccp32 String lpszDSN
lpszDSN="MySQLServer"
nReturn=SQLRemoveDSNFromIni("MySQLServer")
IF nReturn=1

* 工作站计算机或远程登录要用下面语句
* 断开远程登录网络用户
* 局域网络登录了域的用户不用下面命令
* RUN net use \\192.168.0.3\ipc$ /delete

   * =MESSAGEBOX("成功移除了"+lpszDSN+"数据源！",0+64,"提示")
   
ELSE 

* 工作站计算机或远程登录要用下面语句
* 断开远程登录网络用户
* 局域网络登录了域的用户不用下面命令
* RUN net use \\192.168.0.3\ipc$ /delete

    =MESSAGEBOX("移除数据源失败！",0+64,"提示")    
ENDIF     
CLEAR DLLS

 