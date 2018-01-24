% 水体面积计算
clc; clear; close all
lonlim=[117.85 118.3];
latlim=[30.19 30.5];
cpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\';
percname='LC08_L1TP_120039_20160124_20170330_01_T1_'; % 修改
imgdata_G=double(imread([cpath,percname,'B3.TIF']));
imgdata_MIR=double(imread([cpath,percname,'B6.TIF']));
QBdata=double(imread([cpath,percname,'QB.TIF']));
geoinfo=geotiffinfo([cpath,percname,'B3.TIF']);
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
imgdata_G=imgdata_G(LB:LE,CB:CE);
imgdata_MIR=imgdata_MIR(LB:LE,CB:CE);
QBdata=QBdata(LB:LE,CB:CE);
%%
NDWI=(imgdata_G-imgdata_MIR)./(imgdata_G+imgdata_MIR);
res=nan(size(NDWI));
NDWI(imgdata_G==0 & imgdata_MIR==0)=nan;
% 云掩膜
keycloud=bitand(double(QBdata),ones(size(QBdata))*8);
keycloud=logical(keycloud);
NDWI(keycloud)=nan;
% 参数需要调整
res(NDWI<0.3)=1; % 陆地
res(NDWI>=0.3)=2; % 水体
res(isnan(NDWI))=0; % 掩膜
pcolor(flipud(imgdata_G)); shading flat
% 图像保存
res=uint8(res);
imwrite(res,[cpath,percname,'WaterSegment.png']);