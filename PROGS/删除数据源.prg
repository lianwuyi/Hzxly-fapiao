* ��ʽ����ɾ������Դ.prg
* Ӧ�ã����ڹر�ϵͳʱ����


* �Ͽ�������������
SQLDISCONNECT(0)
* ɾ������Դ
DECLARE Integer SQLRemoveDSNFromIni IN odbccp32 String lpszDSN
lpszDSN="MySQLServer"
nReturn=SQLRemoveDSNFromIni("MySQLServer")
IF nReturn=1

* ����վ�������Զ�̵�¼Ҫ���������
* �Ͽ�Զ�̵�¼�����û�
* ���������¼������û�������������
* RUN net use \\192.168.0.3\ipc$ /delete

   * =MESSAGEBOX("�ɹ��Ƴ���"+lpszDSN+"����Դ��",0+64,"��ʾ")
   
ELSE 

* ����վ�������Զ�̵�¼Ҫ���������
* �Ͽ�Զ�̵�¼�����û�
* ���������¼������û�������������
* RUN net use \\192.168.0.3\ipc$ /delete

    =MESSAGEBOX("�Ƴ�����Դʧ�ܣ�",0+64,"��ʾ")    
ENDIF     
CLEAR DLLS

 