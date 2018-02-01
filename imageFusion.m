% µ¥¾°Í¼ÏñÊ±¼äÐòÁÐ
clc; clear;
oilpath=cd;
path=120; row=39;
lonlim=[117.85 118.3];
latlim=[30.19 30.5];
%ID, Date, pLevel, path, row, min_lat, min_lon, max_lat, max_lon
cpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\L8\';
outpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\S1_AutoClip\';
fid=fopen('C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\L8\L8_RGBsceneList.txt');
list=textscan(fid,'%s %s %s %d %d %f %f %f %f','headerlines',1);
cd(cpath)
fclose(fid);
for i=1:length(list{1})
    res=[];
    name=list{1}{i};
    delete('*.tif')
    if 1
        dos(['7za e ',name(1:end-4),'.zip'])
        RGBdata=double(imread([cpath,name]));
        R=(RGBdata(:,:,1));
        G=(RGBdata(:,:,2));
        B=(RGBdata(:,:,3));
        clear RGBdata;
        QBdata=(imread([cpath,name(1:end-4),'_QB.tif']));
        % ÔÆÑÚÄ¨
        keycloud=bitand(double(QBdata),ones(size(QBdata))*8);
        keycloud=logical(keycloud);
        key=keycloud;
        R(key)=nan; G(key)=nan; B(key)=nan;
        % ²ÃÇÐ
        geoinfo=geotiffinfo([cpath,name(1:end-4),'_QB.tif']);
        Height=geoinfo.Height;
        Width=geoinfo.Width;
        [xx,yy]=meshgrid(1:Height,1:Width);
        [xx1,yy1]=pix2map(geoinfo.RefMatrix,xx,yy);
        [lat,lon]=projinv(geoinfo,xx1,yy1);
        lon1D=reshape(lon,1,Height*Width);
        lat1D=reshape(lat,1,Height*Width);
        t1=find_nearest(lon1D,lat1D,lonlim(1),latlim(2));
        t2=find_nearest(lon1D,lat1D,lonlim(2),latlim(1));
        
        res(:,:,1)=R; res(:,:,2)=G; res(:,:,3)=B;
        res(isnan(res))=0;
        res=uint8(res);
        CB=rem(t1(3),Width);
        CE=rem(t2(3),Width);
        LB=ceil(t1(3)/Width);
        LE=ceil(t2(3)/Width);
        res=res(LB:LE,CB:CE,:);
        imwrite(res,[outpath,name(1:end-4),'.png']);
    end
end
delete('*.tif')
cd(oilpath)