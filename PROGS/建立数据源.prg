*  ��ʽ������������Դ.prg
*  Ӧ�ã� ��������ʽ��ʹ��
*  �¼���ʽ�� �����������ݿ���в�ѯ�ĳ�ʽ
*             ���ӣ����ӺͶ�ȡ����.prg


WAIT WINDOW '��ʾ:�������������Ժ򡭡�' NOWAIT NOCLEAR

* ��¼Զ�������û�  Զ�̵�¼�û��� user999  ���룺3638881
* ע��û�е�¼Զ�������û��������ܷ���Զ��SQL���ݿ�
* �������н���user888 Զ���û������侲̬IP��¼����·�����а�Զ�̼����������MAC��ַ��
* ��������������������û����������¼ʱ���Ͳ��ܵ�¼�ˣ�����MAC��ַ��һ������
*****************************************************************

*SQL��װ���������ʱ������վ�������Զ�̵�¼Ҫ���������(SQL�ڷ����������ҵ�¼�������û�����)��
*   ����վ����������û���¼���ɲ�����������
* Զ�̵�¼����������ĵ�¼���ܷ���SQL�����ܽ�����ҵ���������ӡ�
* RUN net use \\192.168.0.3\ipc$ as888## /user:wk13  && �������

* SQL ��װ�ڱ��ط�������û����ķ�������������վ��������������ĵ��û�����¼�����������Զ�̵�¼����
* �Ϳɷ������ݿ⡣

*
CLEAR DLLS
SET SAFETY OFF
* �Ͽ�������������
SQLDISCONNECT(0)

* �趨��������ԴΪ��������,Ϊ����ĳ�ʽ����
RELEASE nReturn
PUBLIC nReturn
nReturn=0 && ��ʼֵΪ 0 ,��δ��������Դ

* ��������Դ
* Ԥ���볣��
#DEFINE   ODBC_Add_DSN      1   && ��������Դ
#DEFINE   ODBC_Config_DSN   2   && �޸�����Դ
#DEFINE   ODBC_Remove_DSN   3   && ɾ������Դ
* ����(���������������������) ��������SQLConfigDataSource �������Լ����� hwndParent ,fRequest,lpszDriver,lpszAttributes
DECLARE INTEGER SQLConfigDataSource IN odbccp32 ;
	INTEGER hwndParent,;
	INTEGER fRequest,;
	STRING lpszDriver,;
	STRING lpszAttributes
* ���ó��������ֵ
hwndParent=NULL  && ��ֵ�͡������ھ����������ΪNULL������ʾ�κζԻ���
lpszDriver="SQL Server"  && �ַ��͡�����������������SQL Server��������������Ϊ��SQL Server��
*
* ���Դ�����: lpszAttributes 
* �ַ��͡��Թؼ��������ʽ�����Դ������а�����Ҫ���ӵ����ݿ���������ơ�Ҫ����������Դ���ơ�
* ����Դ���������ݿ����ơ����ַ�������ʹ�õ����ݿ���������ͬ��������ͬ��
* ���棺
* csqlserver ------���ݿ������ip ����
* ���ӵ�SQL Server ------����Դ����
* MySQLServer ---------����Դ����
* hzxlydb ---------���ݿ�����
lpszAttributes="Server="+csqlserver+CHR(0)+;
	"Description=���ӵ�SQL Server"+CHR(0)+;
	"DSN=MySQLServer"+CHR(0)+;
	"Database=hzxlydb"  &&  ���ݿ�����
	
	
* ����˵��:
* hwndParent ��ֵ�͡������ھ����������ΪNULL������ʾ�κζԻ���	
* fRequest	��ֵ�͡��������͡�fRequest����Ӧ��Ϊ�������е�����֮һֵ

*  ����            ����ֵ           ˵��
* ODBC_ADD_DSN	      1  	        ����һ�����û�����Դ
* ODBC_Config_DSN     2             ���ã��޸ģ�һ���ִ��û�����Դ
* ODBC_Remove_DSN     3             �Ƴ�һ���ִ��û�����Դ

* �������޸ģ���ɾ������Դ�﷨ :	
nReturn=SQLConfigDataSource(0,ODBC_Config_DSN,lpszDriver,lpszAttributes) && �޸����е�����Դ�ɹ�

* ���ؾ��������� ���������ƻ�IP
* lpszAttributes="Server=sdfsdf-gmwf4ty6"+Chr(0)+;

* Զ�������� ip   (��W2003�£���ƹ������ñ�����ip)
* lpszAttributes="Server=192.168.0.3"+Chr(0)+;


* IF nReturn = 1 && �޸����е�����Դ 'MySQLServerPubs2' �ɹ�
* Wait Window '��ʾ���޸����е�����Դ�ɹ���' Timeout 1
* ENDIF

IF nReturn=0   &&����ʧ�ܱ�ʾ������Դ�����ڣ����Խ�������Դ
	nReturn=SQLConfigDataSource(0,ODBC_Add_DSN,lpszDriver,lpszAttributes)  && �������Դ
	IF nReturn > 0  && �������Դ�ɹ�
*		Wait Window '��ʾ����������Դ�ɹ���' Timeout 1
* ��ѯ���ݿ��
* ���ӺͶ�ȡ����.prg
	ELSE
*		=Messagebox("�޷���������Դ�����Ժ����ԣ�",16,"��ʾ")
			WAIT WINDOW '�޷��������ӣ��벻Ҫ�رձ����ڣ�����������������' TIMEOUT 10
			QUIT
			RETURN
	ENDIF
ENDIF
CLEAR DLLS
WAIT TIMEOUT 1 && �ӳ�1��
WAIT CLEAR
