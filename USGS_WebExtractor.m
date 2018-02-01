% ��ҳ��Ϣץ����
clc; clear
% methodsview(COM/interface) % ���󷽷��鿴
% class(obj) % ����������
% get(COM/obj) % �鿴COM����������ֵ
%% ���ݻ�����Ϣ
stert_path='120'; end_path='120';   % �к�
start_row='39'; end_row='39';       % �к�
startDate='1986-04-27'; endDate='1986-04-27'; % ��ֹ����

% ����������
% sensor='LANDSAT_8_C1'; % L8 OLI(2013.4����)
% sensor='LANDSAT_ETM_C1'; % L7 ETM+(2011.10-2013.4)
sensor='LANDSAT_TM_C1'; % L4/5 TM(1984.4-2011.10)

cloudCoverLim=50; % ����ѡ��(<=threshold)
%% Ԫ���ݻ�ȡ
URL=['https://earthexplorer.usgs.gov/EE/InventoryStream/pathrow?start_path=',...
    stert_path,'&end_path=',end_path,'&start_row=',start_row,'&end_row=',end_row,...
    '&sensor=',sensor,'&start_date=',startDate,'&end_date=',endDate,'&format=CSV'];
urlwrite(URL,'tempURL.csv');
[data,URLstr]=xlsread('tempURL.csv');
for i=1:size(URLstr,2)
    if strcmp(URLstr{1,i},'cartURL')
        LocaURL=i;
    end
    if strcmp(URLstr{1,i},'cloudCoverFull')
        LocaCloud=i;
    end
end
URLstr_out=URLstr(2:end,LocaURL);
cloudCover=data(1:end,LocaCloud-7); % �ı����������7��
keyC=cloudCover<=cloudCoverLim;
URLstr_out=URLstr_out(keyC);
cloudCover=cloudCover(keyC);
if exist('tempURL.csv','file')
    delete('tempURL.csv');
end
%% ģ�⽻��
ie=actxserver('internetexplorer.application');
cnt=length(URLstr);
resURL=cell(cnt,1);
for nn=1:cnt
    % ��һ��ҳ��
    url=URLstr{nn};
    ie.Navigate(url);
%     ie.Visible=1;
    tic
    while ~strcmp(ie.ReadyState,'READYSTATE_COMPLETE')
        pause(0.01)
        runtime=toc;
        if runtime>120
            error(['��ַ(',url,')�޷�����,�����������������IE���������',])
        end
    end
    tempURL=[];
    pause(1)
    n=ie.document.links.length;
    for i=1:n
        if strcmp(get(ie.document.links.item(i),'innerHTML'),'<div class="ee-icon ee-icon-download"></div>')
            tempURL=get(ie.document.links.item(i),'outerHTML');
            break
        end
    end
    if ~isempty(tempURL)
        strloca=strfind(tempURL,'"');
        tempURL=tempURL(strloca(1)+1:strloca(2)-1);
    else
        warning(['URL��ȡʧ�ܣ�����������վ������Ϣ���Ժ��ԣ�: ',url]);
        continue
    end
    % �ڶ���ҳ��
    ie.Navigate(tempURL);
    tic
    while ~strcmp(ie.ReadyState,'READYSTATE_COMPLETE')
        pause(0.1)
        runtime=toc;
        if runtime>120
            error(['��ַ(',tempURL,')�޷�����,�����������������IE���������',])
        end
    end
    buttonID=ie.document.body.getElementsByClassName('row clearfix');
    Nclearfix=buttonID.length;
    if Nclearfix~=5
        warning(['URL��ȡʧ�ܣ�����������վ������Ϣ���Ժ��ԣ�: ',tempURL]);
        continue % �Ȳ��ܣ�����������һ��
    end
    key=0;
    for i=1:Nclearfix
        innerText=get(buttonID.item(i),'innerText');
        if ~isempty(strfind(innerText,'Level-1 GeoTIFF Data Product'))
            tempURL=get(buttonID.item(i),'outerHTML');
            key=1;
            break
        end
    end
    if key==0
        warning(['URL��ȡʧ�ܣ�����������վ������Ϣ���Ժ��ԣ�: ',tempURL]);
        continue % �Ȳ��ܣ�����������һ��
    else
        loca=strfind(tempURL,'https://');
        loca2=strfind(tempURL,'/EE');
        resURL{nn,1}=tempURL(loca:loca2+2);
    end
    fprintf('��%d�������������!(��%d��)\n',nn,cnt);
end
fid=fopen('outputURL.txt','w');
for i=1:length(resURL)
    fprintf(fid,'%s\r\n',resURL{i});
end
fclose(fid);
delete(ie)
msgbox('ִ����ϣ����������outputURL.txt��','End');