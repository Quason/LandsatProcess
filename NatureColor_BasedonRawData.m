% ����ԭʼ���ݵ�nature colorͼ��ϳ�
clear;clc
cpath=cd;
pathname='E:\LandsatData\';
outpath='E:\LandsatData\TrueColor\';
lonlim=[117.85 118.3];
latlim=[30.19 30.5];
cd(pathname)
namelist=dir('*.gz');
fclose all;
if exist('unzip','dir')==0
    dos('md unzip')
end
if exist('TrueColor','dir')==0
    dos('md TrueColor')
end
for n=1:length(namelist)
    name=namelist(n).name;
    
    delete([pathname,'\unzip\*.TIF']);
    delete([pathname,'*.tar']);
    dos(['7za e ',name])
    if strcmp(name(1:4),'LC08')
        dos(['7za e ',name(1:end-3),' *B4.TIF',' -o',pathname,'\unzip\'])
        dos(['7za e ',name(1:end-3),' *B3.TIF',' -o',pathname,'\unzip\'])
        dos(['7za e ',name(1:end-3),' *B2.TIF',' -o',pathname,'\unzip\'])
        red=imread([pathname,'\unzip\',name(1:end-7),'_B4.TIF']);
        green=imread([pathname,'\unzip\',name(1:end-7),'_B3.TIF']);
        blue=imread([pathname,'\unzip\',name(1:end-7),'_B2.TIF']);
        geoinfo=geotiffinfo([pathname,'\unzip\',name(1:end-7),'_B2.TIF']);
    elseif strcmp(name(1:4),'LE07')
        dos(['7za e ',name(1:end-3),' *B3.TIF',' -o',pathname,'\unzip\'])
        dos(['7za e ',name(1:end-3),' *B2.TIF',' -o',pathname,'\unzip\'])
        dos(['7za e ',name(1:end-3),' *B1.TIF',' -o',pathname,'\unzip\'])
        red=imread([pathname,'\unzip\',name(1:end-7),'_B3.TIF']);
        green=imread([pathname,'\unzip\',name(1:end-7),'_B2.TIF']);
        blue=imread([pathname,'\unzip\',name(1:end-7),'_B1.TIF']);
        geoinfo=geotiffinfo([pathname,'\unzip\',name(1:end-7),'_B1.TIF']);
    end
    % ����
    res=[];
    Height=geoinfo.Height;
    Width=geoinfo.Width;
    [xx,yy]=meshgrid(1:Height,1:Width);
    [xx1,yy1]=pix2map(geoinfo.RefMatrix,xx,yy);
    [lat,lon]=projinv(geoinfo,xx1,yy1);
    lon1D=reshape(lon,1,Height*Width);
    lat1D=reshape(lat,1,Height*Width);
    t1=find_nearest(lon1D,lat1D,lonlim(1),latlim(2));
    t2=find_nearest(lon1D,lat1D,lonlim(2),latlim(1));
    CB=rem(t1(3),Width);
    CE=rem(t2(3),Width);
    LB=ceil(t1(3)/Width);
    LE=ceil(t2(3)/Width);
    % �Զ��Աȶȣ��������ȷ�Χ������ͼ�������
    res(:,:,1)=red(LB:LE,CB:CE);
    res(:,:,2)=green(LB:LE,CB:CE);
    res(:,:,3)=blue(LB:LE,CB:CE);
    res=AutoContrast(res); % ���������λ�����Σ������ͳһ��3*8λ��ȵ�
    % �Զ�ɫ�ࣨ����ƫɫ����
    
%     % ����Ĩ
%     dos(['7za e ',name(1:end-3),' *BQA.TIF',' -o',pathname,'\unzip\'])
%     BQA=imread([pathname,'\unzip\',name(1:end-7),'_BQA.TIF']);
%     keycloud=BQA>=2^15;
%     SWIR1(keycloud)=nan; NIR(keycloud)=nan; Red(keycloud)=nan;
    % �����ͼ
    imwrite(res,[outpath,name(1:end-7),'.png']);
    fprintf('��%d���ļ��������!\n',n);
end
delete('*.TIF')
delete('*MTL.txt')
fclose all;
cd(cpath)