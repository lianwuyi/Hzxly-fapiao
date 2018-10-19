*  程式名：建立数据源.prg
*  应用： 放在主程式中使用
*  下级程式： 所有连接数据库进行查询的程式
*             例子：连接和读取数据.prg


WAIT WINDOW '提示:正在启动，请稍候……' NOWAIT NOCLEAR

* 登录远程网络用户  远程登录用户： user999  密码：3638881
* 注：没有登录远程网络用户，将不能访问远程SQL数据库
* 服务器中建立user888 远程用户，分配静态IP登录，在路由器中绑定远程计算机的网卡MAC地址，
* 这样其它机器想用这个用户名和密码登录时，就不能登录了（网卡MAC地址不一样）。
*****************************************************************

*SQL安装在域服务器时，工作站计算机或远程登录要用下面语句(SQL在服务器，并且登录本地域用户不用)：
*   工作站计算机用域用户登录，可不用下面的命令。
* 远程登录：并用下面的登录才能访问SQL，才能建立企业管理器连接。
* RUN net use \\192.168.0.3\ipc$ as888## /user:wk13  && 域服务器

* SQL 安装在本地服务器（没有域的服务器），工作站计算机按服务器的的用户名登录，不用上面的远程登录命令
* 就可访问数据库。

*
CLEAR DLLS
SET SAFETY OFF
* 断开所有数据连接
SQLDISCONNECT(0)

* 设定连接数据源为公共变量,为后面的程式引用
RELEASE nReturn
PUBLIC nReturn
nReturn=0 && 初始值为 0 ,即未建立数据源

* 建立数据源
* 预编译常量
#DEFINE   ODBC_Add_DSN      1   && 增加数据源
#DEFINE   ODBC_Config_DSN   2   && 修改数据源
#DEFINE   ODBC_Remove_DSN   3   && 删除数据源
* 声明(建立函数常量或参数变量) 即声明：SQLConfigDataSource 函数，以及参数 hwndParent ,fRequest,lpszDriver,lpszAttributes
DECLARE INTEGER SQLConfigDataSource IN odbccp32 ;
	INTEGER hwndParent,;
	INTEGER fRequest,;
	STRING lpszDriver,;
	STRING lpszAttributes
* 设置常量或变量值
hwndParent=NULL  && 数值型。父窗口句柄。如果句柄为NULL将不显示任何对话框。
lpszDriver="SQL Server"  && 字符型。驱动程序描述，如SQL Server的驱动程序描述为：SQL Server。
*
* 属性串参数: lpszAttributes 
* 字符型。以关键字组合形式的属性串，其中包含了要连接的数据库服务器名称、要建立的数据源名称、
* 数据源描述，数据库名称。该字符串因所使用的数据库驱动程序不同而有所不同。
* 下面：
* csqlserver ------数据库服务器ip 变量
* 连接到SQL Server ------数据源描述
* MySQLServer ---------数据源名称
* hzxlydb ---------数据库名称
lpszAttributes="Server="+csqlserver+CHR(0)+;
	"Description=连接到SQL Server"+CHR(0)+;
	"DSN=MySQLServer"+CHR(0)+;
	"Database=hzxlydb"  &&  数据库名称
	
	
* 参数说明:
* hwndParent 数值型。父窗口句柄。如果句柄为NULL将不显示任何对话框。	
* fRequest	数值型。请求类型。fRequest参数应当为如下所列的其中之一值

*  常量            可用值           说明
* ODBC_ADD_DSN	      1  	        增加一个新用户数据源
* ODBC_Config_DSN     2             配置（修改）一个现存用户数据源
* ODBC_Remove_DSN     3             移除一个现存用户数据源

* 建立或修改，或删除数据源语法 :	
nReturn=SQLConfigDataSource(0,ODBC_Config_DSN,lpszDriver,lpszAttributes) && 修改已有的数据源成功

* 本地局域网络用 服务器名称或IP
* lpszAttributes="Server=sdfsdf-gmwf4ty6"+Chr(0)+;

* 远程网络用 ip   (在W2003下，设计过程中用本机的ip)
* lpszAttributes="Server=192.168.0.3"+Chr(0)+;


* IF nReturn = 1 && 修改已有的数据源 'MySQLServerPubs2' 成功
* Wait Window '提示：修改已有的数据源成功！' Timeout 1
* ENDIF

IF nReturn=0   &&配置失败表示该数据源不存在，所以建立数据源
	nReturn=SQLConfigDataSource(0,ODBC_Add_DSN,lpszDriver,lpszAttributes)  && 添加数据源
	IF nReturn > 0  && 添加数据源成功
*		Wait Window '提示：建立数据源成功！' Timeout 1
* 查询数据库表
* 连接和读取数据.prg
	ELSE
*		=Messagebox("无法建立数据源，请稍后再试！",16,"提示")
			WAIT WINDOW '无法建立连接，请不要关闭本窗口，立即重新启动……' TIMEOUT 10
			QUIT
			RETURN
	ENDIF
ENDIF
CLEAR DLLS
WAIT TIMEOUT 1 && 延迟1秒
WAIT CLEAR
