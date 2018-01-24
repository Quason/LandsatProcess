% 图像读取与拼接
clc; clear;
lonlim=[116 118];
latlim=[30 32];
[mylon,mylat]=meshgrid(lonlim(1):0.00027:lonlim(2),latlim(1):0.00027:latlim(2));
myR=nan(size(mylon)); myG=myR; myB=myR;
%ID, Date, pLevel, path, row, min_lat, min_lon, max_lat, max_lon
cpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\';
fid=fopen('C:\Users\cqy\Desktop\Job\FPI\Landsat\L8_RGBsceneList.txt');
list=textscan(fid,'%s %s %s %d %d %f %f %f %f','headerlines',2);
cd(cpath)
fclose(fid);
for i=1:length(list{1})
    if list{7}(i)<lonlim(2) && list{9}(i)>lonlim(1) && list{6}(i)<latlim(2) && list{8}(i)>latlim(1)
        name=list{1}{i};
        delete('*.tif')
        dos(['7za e ',name(1:end-4),'.zip'])
        data=imread([cpath,name]);
        geoinfo=geotiffinfo([cpath,name(1:end-4),'_QB.tif']);
        Height=geoinfo.Height;
        Width=geoinfo.Width;
        [xx,yy]=meshgrid(1:Height,1:Width);
        [xx1,yy1]=pix2map(geoinfo.RefMatrix,xx,yy);
        [lat,lon]=projinv(geoinfo,xx1,yy1);
        RGBdata=double(imread([cpath,name]));
        R=(RGBdata(:,:,1))';
        G=(RGBdata(:,:,2))';
        B=(RGBdata(:,:,3))';
        clear RGBdata;
        QBdata=(imread([cpath,name(1:end-4),'_QB.tif']))';
        % 云掩抹和经纬度范围掩膜
        keycloud=bitand(double(QBdata),ones(size(QBdata))*8);
        keycloud=logical(keycloud);
        key=lon<lonlim(1)|lon>lonlim(2)|lat<latlim(1)|lat>latlim(2)|keycloud;
        R(key)=nan; G(key)=nan; B(key)=nan;
        % 地理重投影
        myR=griddata(lon,lat,R,mylon,mylat,'nearest');
        clear xx yy xx1 yy1
    end
end