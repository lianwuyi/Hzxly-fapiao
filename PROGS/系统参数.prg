* 取出网络计算机名,工作站名
WAIT WINDOW '正在建立网络连接，请稍候……' NOWAIT NOCLEAR
SET SAFETY OFF && 决定改写已有文件之前是否显示对话框
SET TALK OFF  && 决定 Visual FoxPro 是否显示命令结果
SET CENT ON  && 显示年份为4位
SET DATE ANSI && yy.mm.dd (年月日格式)
SET DELETE ON  && ON 为使用范围子句处理记录(包括在相关表中的记录)的命令忽略标有删除标记的记录。
SET EXCL OFF && (私有数据工作期的默认方式)允许网络上的任何用户共享和修改网络上打开的表。
set help on && 允许打开帮助
* SET DEFAULT TO c:\

CD "\hzxly\"
SET PATH TO ;DATA;INCLUDE;FORMS;GRAPHICS;HELP;LIBS;MENUS;PROGS;REPORTS;BMP;BMPS

RELE cPATHS,c网络计算机,c版本号,c公司,c注册号,csqlserver
PUBLIC cPATHS,c网络计算机,c版本号,c公司,c注册号,csqlserver
SELECT 0
USE ..\DATA\sys1.DBF
c服务器名称 = ALLTRIM(服务器名称)
c网络计算机 = ALLTRIM(网络计算机)
c注册号 = ALLTRIM(注册号)
c公司 = ALLTRIM(公司名)
* c菜单名称 = alltrim(菜单名称)
*cPATHS = '\\'+c服务器名称+'\SYSDBū$\'  && 业务系统共享数据库文件夹
* cPATHS_cw = '\\'+ALLTRIM(cw_name)+'\CXDBū$\'  && 财务部数据共享文件夹
csqlserver = ALLTRIM(sqlserver)
USE
c版本号 = '2009.01.06 编译,1.7 版 '

**************************************************************************************
* 特别注意：SQL如果安装在域服务器，如未登录域的用户，就是远程用户，一定要用下面命令，才能连接SQL数据库！！
* 远程联接时用
*  as3638881# 是密码  user888 是远程用户
*  lnss = '\\'+csqlserver+'\ipc$' +CHR(0)+ 'as3638881#' +CHR(0) + '/user:user888'
*  RUN net use &lnss
***
*  SQL如果安装在本地服务器（服务器没有安装域的）就不用远程登录网络的命令，只要服务器中有该用户名即可。
 

* RUN ping -a &csqlserver
* 在WINDOWS 2003 服务器上建立一个SQL登录用户
*lnss = '\\'+csqlserver+'\ipc$' +CHR(0)+ 'as3638881#' +CHR(0) + '/user:sqluser'
*RUN net use &lnss
* DO ..\PROGS\建立数据源.prg
*
** 以下为表示已建立数据源的变量值，不用更改以前写的命令  
 Release nReturn
 Public nReturn
 nReturn=1 && 初始值为 1   
*****************************************

WAIT WINDOW '提示:正在建立数据库连接，请稍候……' NOWAIT NOCLEAR

* 断开所有数据库连接
SQLDISCONNECT(0)

* 设定连接句柄为公共变量,可以为后面的程式引用
RELEASE lnHandle
PUBLIC lnHandle
lnHandle = 0

*连接数据库
DO ..\PROGS\连接数据库.prg

WAIT WINDOW '提示:正在查询用户数据表……' NOWAIT NOCLEAR
IF lnHandle > 0 && 连接成功,返回非 0 正数
*	=SQLEXEC(lnHandle,'select * from mmk ')  &&读取mmk表数据
	=SQLExec(lnHandle,'select * from mmk WHERE RTRIM(LTRIM(注册号)) = ?c注册号')
*	 SELECT sqlresult
	COPY ALL TO ..\test.DBF
	USE
	SELECT 0
	USE ..\test.DBF
	COUNT TO ss
	USE
	
	IF ss = 0
 
* 以下连接不成功的命令行
* 断开所有数据连接
		SQLDISCONNECT(0) && 断开所有数据连接
		RELEASE lnHandle && 删除连接句柄变量
		CLEAR DLLS
		WAIT WINDOW '提示:没找到指定注册号的用户，请联系系统管理员……' TIMEOUT 4
		QUIT

		RETURN
	ENDIF

	WAIT WINDOW '提示:已完成用户数据表查询……' NOWAIT NOCLEAR
	USE ..\DATA\mmk1.DBF EXCLUSIVE
	ZAP
	APPEND FROM ..\test.DBF
	USE
	DELETE FILE ..\test.DBF
	WAIT CLEAR
* 先断开连接，再删除数据源，删除DLL变量，删除本程式公共变量
* 断开所有数据连接
	SQLDISCONNECT(0)
*	删除DLL变量，删除本程式公共变量
	RELEASE lnHandle && 删除连接句柄变量
	CLEAR DLLS

* 登录表单
*	DO FORM ..\forms\login.scx


ELSE
* 以下连接不成功的命令行
* 断开所有数据连接
	SQLDISCONNECT(0) && 断开所有数据连接
	RELEASE lnHandle && 删除连接句柄变量
	CLEAR DLLS
	WAIT WINDOW '提示:未能连接数据库,不能查询数据,请稍后再试……' TIMEOUT 4
	QUIT
	RETURN
ENDIF
