*连接数据库
************************************************************************************************************************************
* =SQLSETPROP() 函数 用法
* = SQLSETPROP(0,'Transactions', 2) && 设置成手工事务处理模式，由代码来控制      Transactions 为事务处理属性， 设置为 2 是人工处理
******
* DISPLOGIN,该属性控制是否显示SQL SERVER的登录表单  
*第3个参数： 1 - 显示登录表单，如果登录信息(用户名，密码)不完全   2 - 总显示登录表单  3 - 不显示登录表单  
*例如：  
*=SQLSETPROP(lnHandle, "DISPLOGIN",1) 
*************************************************************************************************************************************
=SQLSetprop(0,"DispLogin",3) && 当连接不成功时，关闭系统提示（数据库连接超期的提示）,&&登录失败时不显示ODBC登录对话框
lnHandle =SQLConnect("MySQLServer","user888","3b7d29akfq93lgs8") && 建立数据库连接
