clear;clc
cpath=cd;
cd E:\LandsatData\
namelist=dir('*.gz');
fclose all;
for n=1:length(namelist)
    name=namelist(n).name;
    delete('*.tar')
    delete('*.TIF')
    delete('*MTL.txt')
    dos(['7za e ',name])
    dos(['7za e ',name(1:end-3),' *MTL.txt'])
    fid=fopen([name(1:end-7),'_MTL.txt']);
    data=textscan(fid,'%s','Delimiter','\n');
    fid=fopen('E:\LandsatData\L8_RAWsceneList.txt','w');
    % Ð´ÎÄ¼þÍ·
    fwrite(fid,'productID, acquisitionDate, path, row, min_lat, min_lon, max_lat, max_lon');
    for i=1:length(data{1})
        tstr=data{1}{i};
        if length(tstr)>21 && strcmp(tstr(1:21),'CORNER_UL_LAT_PRODUCT')
            UL_lat=str2double(tstr(strfind(tstr,'=')+1:end));
            break
        end
    end
    tstr=data{1}{i+1};
    UL_lon=str2double(tstr(strfind(tstr,'=')+1:end));
    tstr=data{1}{i+2};
    UR_lat=str2double(tstr(strfind(tstr,'=')+1:end));
    tstr=data{1}{i+3};
    UR_lon=str2double(tstr(strfind(tstr,'=')+1:end));
    tstr=data{1}{i+4};
    LL_lat=str2double(tstr(strfind(tstr,'=')+1:end));
    tstr=data{1}{i+5};
    LL_lon=str2double(tstr(strfind(tstr,'=')+1:end));
    tstr=data{1}{i+6};
    LR_lat=str2double(tstr(strfind(tstr,'=')+1:end));
    tstr=data{1}{i+7};
    LR_lon=str2double(tstr(strfind(tstr,'=')+1:end));
    fprintf(fid,'productID, acquisitionDate, path, row, min_lat, min_lon, max_lat, max_lon');
    fprintf(fid,'\r\n');
    fprintf(fid,[name(1:end-7),' ']);
    fprintf(fid,[name(18:25),' ']);
    fprintf(fid,'%d %d ',str2double(name(11:13)),str2double(name(14:16)));
    minLat=min([UL_lat,UR_lat,LL_lat,LR_lat]);
    maxLat=max([UL_lat,UR_lat,LL_lat,LR_lat]);
    minLon=min([UL_lon,UR_lon,LL_lon,LR_lon]);
    maxLon=max([UL_lon,UR_lon,LL_lon,LR_lon]);
    fprintf(fid,'%f %f %f %f',minLat,minLon,maxLat,maxLon);
end
delete('*.TIF')
delete('*MTL.txt')
fclose all;
cd(cpath)