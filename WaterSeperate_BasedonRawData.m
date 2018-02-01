% 基于原始数据的nature color图像合成
clear;clc
cpath=cd;
pathname='E:\LandsatData\';
outpath='E:\LandsatData\WaterSeparate\';
lonlim=[117.85 118.3];
latlim=[30.19 30.5];
cd(pathname)
namelist=dir('*.gz');
fclose all;
if exist('unzip','dir')==0
    dos('md unzip')
end
if exist('WaterSeparate','dir')==0
    dos('md WaterSeparate')
end
for n=52:length(namelist)
    name=namelist(n).name;
    delete([pathname,'\unzip\*.TIF']);
    delete([pathname,'*.tar']);
    dos(['7za e ',name])
    if strcmp(name(1:4),'LC08')
        dos(['7za e ',name(1:end-3),' *B3.TIF',' -o',pathname,'\unzip\'])
        dos(['7za e ',name(1:end-3),' *B6.TIF',' -o',pathname,'\unzip\'])
        NDWI1=double(imread([pathname,'\unzip\',name(1:end-7),'_B3.TIF']));
        NDWI2=double(imread([pathname,'\unzip\',name(1:end-7),'_B6.TIF']));
        geoinfo=geotiffinfo([pathname,'\unzip\',name(1:end-7),'_B3.TIF']);
    else
        dos(['7za e ',name(1:end-3),' *B2.TIF',' -o',pathname,'\unzip\'])
%         dos(['7za e ',name(1:end-3),' *B5.TIF',' -o',pathname,'\unzip\'])
        dos(['7za e ',name(1:end-3),' *B4.TIF',' -o',pathname,'\unzip\'])
        NDWI1=double(imread([pathname,'\unzip\',name(1:end-7),'_B2.TIF']));
%         NDWI2=double(imread([pathname,'\unzip\',name(1:end-7),'_B5.TIF']));
        NDWI2=double(imread([pathname,'\unzip\',name(1:end-7),'_B4.TIF']));
        geoinfo=geotiffinfo([pathname,'\unzip\',name(1:end-7),'_B2.TIF']);
    end
    % 裁切
    Height=geoinfo.Height;
    Width=geoinfo.Width;
    [xx,yy]=meshgrid(1:Height,1:Width);
    [xx1,yy1]=pix2map(geoinfo.RefMatrix,xx,yy);
    [lat,lon]=projinv(geoinfo,xx1,yy1);
    ULt=abs(lon-lonlim(1))+abs(lat-latlim(2));
    [~,UL]=min(ULt(:));
    LRt=abs(lon-lonlim(2))+abs(lat-latlim(1));
    [~,LR]=min(LRt(:));
    CB=rem(UL,Width);
    CE=rem(LR,Width);
    LB=ceil(UL/Width);
    LE=ceil(LR/Width);
%     % 云掩抹
%     dos(['7za e ',name(1:end-3),' *BQA.TIF',' -o',pathname,'\unzip\'])
%     BQA=imread([pathname,'\unzip\',name(1:end-7),'_BQA.TIF']);
%     BQA=BQA(LB:LE,CB:CE);
%     keycloud=BQA>=2^15;
%     NDWI1(keycloud)=nan; NDWI2(keycloud)=nan;
    % NDWI指数计算
    NDWI1=NDWI1(LB:LE,CB:CE);
    NDWI2=NDWI2(LB:LE,CB:CE);
    NDWI=(NDWI1-NDWI2)./(NDWI1+NDWI2);
    % 对Landsat 7的异常条带进行处理
    if strcmp(name(1:4),'LE07')
        NDWI(NDWI==1|NDWI==-1)=nan;
        NDWI=LE7_PATCH(NDWI);
    end
    threshold=LW_threshold(NDWI);
    res=uint8(NDWI);
    res(NDWI<threshold)=255;
    res(NDWI>=threshold)=0;
    imwrite(res,[outpath,name(1:end-7),'_WaterLand.png'])
    fprintf('第%d个文件处理完毕!\n',n);
end
delete('*.TIF')
delete('*MTL.txt')
fclose all;
cd(cpath)