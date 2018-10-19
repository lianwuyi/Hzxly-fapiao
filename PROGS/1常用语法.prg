* 常用语法：
* DoDefault() && 继续执行默认代码  
* thisform.货品编码1.setfocus  &&光标

* && 取整数   floor(val(str(n_cfid)))       floor() 取整，去掉空格,  int() 取整是不去掉空格； CEILING(3.1) = 4   int(3.1) = 3  

* ThisForm.Refresh()  && 刷新表单
* THISFORM.Grid1.Refresh()  && 刷新表格
* 货品编码: 写入2 = 'Y'  rele 类别s,货品编码s,品名规格s,单位s,单价s,货架号s,备注s,颜色s

*打印机：REPORT FORM c:\jck\forms\计划成品表.frx NOEJECT NOCONSOLE TO PRINTER   
*        REPORT FORM ..\forms\dzbg.frx NOEJECT NOCONSOLE PREV
******************************************************
** 保存按钮
*  =cursorsetprop("Buffering",5)
*   =tableupdate(.t.)             && 保存数据
*  thisform.cmd添加.enabled=.t.
*  thisform.cmd保存.enabled=.f.
*  thisform.cmd放弃.enabled=.f.
*  thisform.cmd修改.enabled=.t.
*  ThisForm.Refresh()

*  =cursorsetprop("Buffering",2)
*  wait window '已保存在临时表，请记帐' nowait noclear
******************************************************

* 1024 * 768  表单：高 630 宽：880

*   TOTAL TO TableName ON FieldName   [FIELDS FieldNameList]   [Scope]
*       [FOR lExpression1]   [WHILE lExpression2]   [NOOPTIMIZE]

****************************************************************
* IF file("..\ck\arjs\&dbfs"+".arj")=.T.

*  wait windows "文件重名,请重新输入！" AT 8,30 TIMEOUT  2
* return
* ENDIF
** -g:10748612 为加密码压缩，-g: 密码开关， "10748612" 为密码
**解压时，要带上密码开关才能解压缩


* run arj a -g:10748612 ..\ck\arjs\&dbfs  ..\ck\data\*.*
* run arj e -g:10748612  "\fapiao\arjs\&dbfs_1

********************************************************
*     INDEX ON eExpression TO IDXFileName | TAG TagName [OF CDXFileName]
*     [FOR lExpression]
 *    [COMPACT]
  *   [ASCENDING | DESCENDING]
   *  [UNIQUE | CANDIDATE]
    * [ADDITIVE]
****

 *************************
*   select *  from cPATHS+'syslydj.dbf' ;
*        where alltrim(联业订单号) == djh1 ;
*        into table ..\test.dbf
*      into cursor tmp

*  UPDATE cPATHS+'syslydj.dbf' SET 完成记号 = "*" , 完成日期 = rq1 WHERE alltrim(联业订单号) == djh1
 **************************        
 
 ***生成 Excel 表：************************************
*  USE c:\bjxt\data\传真表.dbf AGAIN IN 0 ALIAS 传真表
*    SELECT 传真表
*    BROWSE LAST
*    COPY TO "c:\bjxt\e-mail_html\2.xls" TYPE XL5
*
********************************************************
*打印机：REPORT FORM c:\jck\forms\计划成品表.frx NOEJECT NOCONSOLE TO PRINTER  

