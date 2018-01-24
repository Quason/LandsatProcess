% FPI RGB图像经纬度范围生成
clc; clear; close all
cd C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\
namelist=dir('*.zip');
fid=fopen('C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\L8_RGBsceneList.txt','w');
% 写文件头
fwrite(fid,'productID, acquisitionDate, processingLevel, path, row, min_lat, min_lon, max_lat, max_lon');
n=2;
for i=1:length(namelist)
    name=namelist(i).name;
    if strcmp(name(end-4),'1')
        delete('*.tif')
        dos(['7za e ',name])
        info=geotiffinfo([name(1:end-4),'_QB.tif']);
        Height=info.Height;
        Width=info.Width;
        [xUL,yUL]=pix2map(info.RefMatrix,1,1);
        [latUL,lonUL]=projinv(info,xUL,yUL);
        [xDL,yDL]=pix2map(info.RefMatrix,Height,1);
        [latDL,lonDL]=projinv(info,xDL,yDL);
        [xUR,yUR]=pix2map(info.RefMatrix,1,Width);
        [latUR,lonUR]=projinv(info,xUR,yUR);
        [xDR,yDR]=pix2map(info.RefMatrix,Height,Width);
        [latDR,lonDR]=projinv(info,xDR,yDR);
        minLon=min([lonUL lonUR lonDL lonDR]);
        minLat=min([latUL latUR latDL latDR]);
        maxLon=max([lonUL lonUR lonDL lonDR]);
        maxLat=max([latUL latUR latDL latDR]);
        fprintf(fid,'\r\n');
        fprintf(fid,[name(1:end-4),'.tif ']);
        fprintf(fid,[name(18:25),' ']);
        fprintf(fid,[name(6:9),name(39:40),' ']);
        fprintf(fid,'%d %d ',str2double(name(11:13)),str2double(name(14:16)));
        fprintf(fid,'%f %f %f %f',minLat,minLon,maxLat,maxLon);
        n=n+1;
        delete('*.tif')
    end
end
fclose(fid);