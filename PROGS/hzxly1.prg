
lcLastSetPath=SET("PATH")
CD "\hzxly\"
SET PATH TO ;DATA;INCLUDE;FORMS;GRAPHICS;HELP;LIBS;MENUS;PROGS;REPORTS;BMP;BMPS
_SCREEN.Caption = "登录系统"
_SCREEN.Icon = "..\bmp\cx2.ico"
_SCREEN.Picture = "..\bmp\gs1.bmp"                                             
****************************
DO ..\PROGS\系统参数.prg

SET STATUS BAR ON && 显示或移去图形状态栏 ,on 默认状态栏
SET SYSMENU TO  && 不带其他参数的 SET SYSMENU TO 命令废止 Visual FoxPro 主菜单栏
SET ECHO OFF  && (默认值)关闭 FoxPro 2.0 以前版本中的跟踪窗口
SET ESCAPE OFF && 禁止运行的程序和命令在按 Esc 键后被中断。
* SET SCOREBOARD OFF && 关闭状态栏显示，老版本的命令FoxBASE+ 2。1 的，现可去掉 
*
SET SAFETY OFF && 决定改写已有文件之前是否显示对话框
SET TALK OFF  && 决定 Visual FoxPro 是否显示命令结果
SET CENT ON  && 显示年份为4位
SET DATE ANSI && yy.mm.dd (年月日格式)
SET DELETE ON  && ON 为使用范围子句处理记录(包括在相关表中的记录)的命令忽略标有删除标记的记录。
SET EXCL OFF && (私有数据工作期的默认方式)允许网络上的任何用户共享和修改网络上打开的表。
set help on && 允许打开帮助
* 设定打开的帮助文件
* set help to "C:\Program Files\Microsoft Visual Studio\MSDN98\98VS\2052\FOXHELP.CHM"


* 更改主窗口属性
_SCREEN.Caption = "登录系统"
_SCREEN.Icon = "..\bmp\cx2.ico"
_SCREEN.Picture = "..\bmp\gs1.bmp"
*MODIFY WINDOW SCREEN FROM 0.00, 0.00 TO 36.00,131.000   &&更改桌面 ，800*600
MODIFY WINDOW SCREEN FROM 0.00, 0.00 TO  48.00,167.500   &&更改桌面 ，1024*768
 
*系统登录 

@45,108 SAY c版本号 ;
 	 FONT "宋体" ,18 ;
     STYLE "BIUT";
     COLOR RGB(0,0,0,,,)
     
DO FORM '..\forms\login.scx'

if mem_on="OFF"
* THISFORM.Release
CLOSE data ALL
close TABLES ALL 
* 删除临时表 
CLOSE data ALL
close TABLES ALL 
SELECT 0
USE ..\data\mmk1.dbf EXCLUSIVE 
ZAP
USE

DO ..\PROGS\quit.prg
endif

IF  mem_on="ON"
* 删除临时表 
CLOSE data ALL
close TABLES ALL 
SELECT 0
USE ..\data\mmk1.dbf EXCLUSIVE 
ZAP
USE


   * 恢复桌面窗口
   * MODIFY WINDOW SCREEN FROM 0.00, 0.00 TO 36.00,131.000   &&更改桌面 ，800*600
   MODIFY WINDOW SCREEN FROM 0.00, 0.00 TO  48.00,167.500   &&更改桌面 ，1024*768
   * 恢复系统菜单
   * SET SYSMENU TO DEFAULT
   DO '..\progs\hzxly.PRG'

ELSE
 * 恢复系统菜单
      SET SYSMENU TO DEFAULT
     * 恢复桌面窗口
     * MODIFY WINDOW SCREEN  FROM 0, 0 TO 30.00,104.20   &&640*480
     * MODIFY WINDOW SCREEN FROM 0.00, 0.00 TO 36.00,131.000   &&更改桌面 ，800*600
     MODIFY WINDOW SCREEN FROM 0.00, 0.00 TO  48.00,167.500   &&更改桌面 ，1024*768
     SET STATUS BAR ON
     CLEAR
     RETU

ENDIF