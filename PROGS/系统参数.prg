* ȡ������������,����վ��
WAIT WINDOW '���ڽ����������ӣ����Ժ򡭡�' NOWAIT NOCLEAR
SET SAFETY OFF && ������д�����ļ�֮ǰ�Ƿ���ʾ�Ի���
SET TALK OFF  && ���� Visual FoxPro �Ƿ���ʾ������
SET CENT ON  && ��ʾ���Ϊ4λ
SET DATE ANSI && yy.mm.dd (�����ո�ʽ)
SET DELETE ON  && ON Ϊʹ�÷�Χ�Ӿ䴦���¼(��������ر��еļ�¼)��������Ա���ɾ����ǵļ�¼��
SET EXCL OFF && (˽�����ݹ����ڵ�Ĭ�Ϸ�ʽ)���������ϵ��κ��û�������޸������ϴ򿪵ı�
set help on && ����򿪰���
* SET DEFAULT TO c:\

CD "\hzxly\"
SET PATH TO ;DATA;INCLUDE;FORMS;GRAPHICS;HELP;LIBS;MENUS;PROGS;REPORTS;BMP;BMPS

RELE cPATHS,c��������,c�汾��,c��˾,cע���,csqlserver
PUBLIC cPATHS,c��������,c�汾��,c��˾,cע���,csqlserver
SELECT 0
USE ..\DATA\sys1.DBF
c���������� = ALLTRIM(����������)
c�������� = ALLTRIM(��������)
cע��� = ALLTRIM(ע���)
c��˾ = ALLTRIM(��˾��)
* c�˵����� = alltrim(�˵�����)
*cPATHS = '\\'+c����������+'\SYSDB��$\'  && ҵ��ϵͳ�������ݿ��ļ���
* cPATHS_cw = '\\'+ALLTRIM(cw_name)+'\CXDB��$\'  && �������ݹ����ļ���
csqlserver = ALLTRIM(sqlserver)
USE
c�汾�� = '2009.01.06 ����,1.7 �� '

**************************************************************************************
* �ر�ע�⣺SQL�����װ�������������δ��¼����û�������Զ���û���һ��Ҫ�����������������SQL���ݿ⣡��
* Զ������ʱ��
*  as3638881# ������  user888 ��Զ���û�
*  lnss = '\\'+csqlserver+'\ipc$' +CHR(0)+ 'as3638881#' +CHR(0) + '/user:user888'
*  RUN net use &lnss
***
*  SQL�����װ�ڱ��ط�������������û�а�װ��ģ��Ͳ���Զ�̵�¼��������ֻҪ���������и��û������ɡ�
 

* RUN ping -a &csqlserver
* ��WINDOWS 2003 �������Ͻ���һ��SQL��¼�û�
*lnss = '\\'+csqlserver+'\ipc$' +CHR(0)+ 'as3638881#' +CHR(0) + '/user:sqluser'
*RUN net use &lnss
* DO ..\PROGS\��������Դ.prg
*
** ����Ϊ��ʾ�ѽ�������Դ�ı���ֵ�����ø�����ǰд������  
 Release nReturn
 Public nReturn
 nReturn=1 && ��ʼֵΪ 1   
*****************************************

WAIT WINDOW '��ʾ:���ڽ������ݿ����ӣ����Ժ򡭡�' NOWAIT NOCLEAR

* �Ͽ��������ݿ�����
SQLDISCONNECT(0)

* �趨���Ӿ��Ϊ��������,����Ϊ����ĳ�ʽ����
RELEASE lnHandle
PUBLIC lnHandle
lnHandle = 0

*�������ݿ�
DO ..\PROGS\�������ݿ�.prg

WAIT WINDOW '��ʾ:���ڲ�ѯ�û����ݱ���' NOWAIT NOCLEAR
IF lnHandle > 0 && ���ӳɹ�,���ط� 0 ����
*	=SQLEXEC(lnHandle,'select * from mmk ')  &&��ȡmmk������
	=SQLExec(lnHandle,'select * from mmk WHERE RTRIM(LTRIM(ע���)) = ?cע���')
*	 SELECT sqlresult
	COPY ALL TO ..\test.DBF
	USE
	SELECT 0
	USE ..\test.DBF
	COUNT TO ss
	USE
	
	IF ss = 0
 
* �������Ӳ��ɹ���������
* �Ͽ�������������
		SQLDISCONNECT(0) && �Ͽ�������������
		RELEASE lnHandle && ɾ�����Ӿ������
		CLEAR DLLS
		WAIT WINDOW '��ʾ:û�ҵ�ָ��ע��ŵ��û�������ϵϵͳ����Ա����' TIMEOUT 4
		QUIT

		RETURN
	ENDIF

	WAIT WINDOW '��ʾ:������û����ݱ��ѯ����' NOWAIT NOCLEAR
	USE ..\DATA\mmk1.DBF EXCLUSIVE
	ZAP
	APPEND FROM ..\test.DBF
	USE
	DELETE FILE ..\test.DBF
	WAIT CLEAR
* �ȶϿ����ӣ���ɾ������Դ��ɾ��DLL������ɾ������ʽ��������
* �Ͽ�������������
	SQLDISCONNECT(0)
*	ɾ��DLL������ɾ������ʽ��������
	RELEASE lnHandle && ɾ�����Ӿ������
	CLEAR DLLS

* ��¼��
*	DO FORM ..\forms\login.scx


ELSE
* �������Ӳ��ɹ���������
* �Ͽ�������������
	SQLDISCONNECT(0) && �Ͽ�������������
	RELEASE lnHandle && ɾ�����Ӿ������
	CLEAR DLLS
	WAIT WINDOW '��ʾ:δ���������ݿ�,���ܲ�ѯ����,���Ժ����ԡ���' TIMEOUT 4
	QUIT
	RETURN
ENDIF
