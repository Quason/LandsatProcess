% 对Landsat影像进行裁切、辐射定标、几何粗校正（去除瑞利散射）,最终得到表观反射率ρ
clear;clc
cpath=cd;
pathname='E:\LandsatData\';
outpath='E:\LandsatData\RayleighCorr\';
lonlim=[117.85 118.3];
latlim=[30.19 30.5];
cd(pathname)
namelist=dir('*.gz');
fclose all;
if exist('unzip','dir')==0
    dos('md unzip')
end
if exist('RayleighCorr','dir')==0
    dos('md RayleighCorr')
end
cnt=length(namelist);
for n=1:cnt
    name=namelist(n).name;
    fclose all;
    delete([pathname,'\unzip\**']);
    delete([pathname,'*.tar']);
    dos(['7za e ',name])
    dos(['7za e ',name(1:end-3),' -o',pathname,'\unzip\'])
    geoinfo=geotiffinfo([pathname,'\unzip\',name(1:end-7),'_B1.TIF']);
    % 裁切
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
    % 卫星信息
    SOLA=nan; SOLZ=nan;
    SUN_dis=nan; MULT_ADD=[];
    MLT_fid=fopen([pathname,'unzip/',name(1:end-7),'_MTL.txt']);
    imginfo=textscan(MLT_fid,'%s','Delimiter','\n');
    for i=1:length(imginfo{1})
        tstr=imginfo{1}{i};
        if length(tstr)>11 && strcmp(tstr(1:11),'SUN_AZIMUTH')
            SOLA=str2double(tstr(strfind(tstr,'=')+1:end));
            ttstr=imginfo{1}{i+1};
            SOLZ=90-str2double(ttstr(strfind(ttstr,'=')+1:end));
            ttstr=imginfo{1}{i+2};
            SUN_dis=str2double(ttstr(strfind(ttstr,'=')+1:end));
        elseif length(tstr)>20 && strcmp(tstr(1:20),'RADIANCE_MULT_BAND_1') && strcmp(name(1:4),'LC08')
            nBAND=11;
            wavelength=[443 482 561 655 865 1609 2201 590 1373 10800 12000];
            tau=[0.2352 0.1685 0.0902 0.04793 0.01551 0.001284 0.0003697 0.0727788 0.00241 0 0];
            f0=[189.625 200.396 182.079 155.038 95.063 24.755 8.546 169.347 36.69 0 0];
            for ii=1:nBAND
                ttstr_1=imginfo{1}{i+(ii-1)};
                ttstr_2=imginfo{1}{i+(ii-1)+nBAND};
                MULT_ADD(ii,1)=str2double(ttstr_1(strfind(ttstr_1,'=')+1:end));
                MULT_ADD(ii,2)=str2double(ttstr_2(strfind(ttstr_2,'=')+1:end));
            end
            break
        elseif length(tstr)>23 && strcmp(tstr(1:23),'RADIANCE_MAXIMUM_BAND_1') && (~strcmp(name(1:4),'LC08'))
            if strcmp(name(1:4),'LE07')
                wavelength=[485 560 660 835 1650 11450 11450 2215 710];
                f0=[193.735 176.756 153.988 103.581 23.0019 0 0 8.33632 140.18];
                tau=[0.162147 0.0900236 0.0461493 0.0178264 0.00115438 0 0 0.000354774 0.0343288];
                nBAND=9;
            else
                wavelength=[485 560 660 830 1650 11450 2215];
                f0=[193.735 176.153 153.988 105.445 23.0019 0 8.33632];
                tau=[0.162147 0.0900236 0.0461493 0.0182636 0.00115438 0 0.000354774];
                nBAND=7;
            end
            for ii=1:nBAND
                ttstr_1=imginfo{1}{i+(ii-1)*2};
                ttstr_2=imginfo{1}{i+(ii-1)*2+1};
                RAD_maxmin(ii,1)=str2double(ttstr_1(strfind(ttstr_1,'=')+1:end));
                RAD_maxmin(ii,2)=str2double(ttstr_2(strfind(ttstr_2,'=')+1:end));
            end
        elseif length(tstr)>23 && strcmp(tstr(1:23),'QUANTIZE_CAL_MAX_BAND_1') && (~strcmp(name(1:4),'LC08'))
            for ii=1:nBAND
                ttstr_1=imginfo{1}{i+(ii-1)*2};
                ttstr_2=imginfo{1}{i+(ii-1)*2+1};
                QUA_maxmin(ii,1)=str2double(ttstr_1(strfind(ttstr_1,'=')+1:end));
                QUA_maxmin(ii,2)=str2double(ttstr_2(strfind(ttstr_2,'=')+1:end));
            end
            break
        end
    end
    % 辐射校正
    for i=1:nBAND
        if strcmp(name(1:4),'LE07')
            if i==6
                data=double(imread([pathname,'unzip\',name(1:end-7),'_B6_VCID_1.TIF']));
                outname=[name(1:end-7),'_B6VCID1','Rho'];
            elseif i==7
                data=double(imread([pathname,'unzip\',name(1:end-7),'_B6_VCID_2.TIF']));
                outname=[name(1:end-7),'_B6VCID2','Rho'];
            elseif i>7
                data=double(imread([pathname,'unzip\',name(1:end-7),'_B',num2str(i-1),'.TIF']));
                outname=[name(1:end-7),'_B',num2str(i-1),'Rho'];
            else
                data=double(imread([pathname,'unzip\',name(1:end-7),'_B',num2str(i),'.TIF']));
                outname=[name(1:end-7),'_B',num2str(i),'Rho'];
            end
            data=data(LB:LE,CB:CE);
            Radi=(RAD_maxmin(i,1)-RAD_maxmin(i,2))/(QUA_maxmin(i,1)-QUA_maxmin(i,2))*(data-QUA_maxmin(i,2))+RAD_maxmin(i,2);
        elseif strcmp(name(1:4),'LC08')
            data=double(imread([pathname,'unzip\',name(1:end-7),'_B',num2str(i),'.TIF']));
            data=data(LB:LE,CB:CE);
            Radi=data*MULT_ADD(i,1)+MULT_ADD(i,2);
            outname=[name(1:end-7),'_B',num2str(i),'Rho'];
        else
            data=double(imread([pathname,'unzip\',name(1:end-7),'_B',num2str(i),'.TIF']));
            data=data(LB:LE,CB:CE);
            Radi=(RAD_maxmin(i,1)-RAD_maxmin(i,2))/(QUA_maxmin(i,1)-QUA_maxmin(i,2))*(data-QUA_maxmin(i,2))+RAD_maxmin(i,2);
            outname=[name(1:end-7),'_B',num2str(i),'Rho'];
        end
        % 扣除瑞利散射
        Radi=Radi/10; % 统一数量级
        Lr=fun_getLR(tau(i),f0(i),SOLZ,SOLA,0,0);
        Rayleigh=Lr/SUN_dis^2;
        Lri=Radi-Rayleigh;
        % 表观反射率计算
        Rho=pi*Lri*SUN_dis^2/f0(i)/cos(deg2rad(SOLZ));
        % 保存数据
        eval([outname,'=Rho;']);
        if exist([outpath,name(18:25)],'dir')==0
            dos(['md ',outpath,name(18:25)])
        end
        save([outpath,name(18:25),'\',outname,'.mat'],outname);
    end
    fprintf('第%d个文件处理完毕(共%d个)!\n',n,cnt);
end
delete('*.TIF')
delete('*MTL.txt')
delete([pathname,'*.tar']);
fclose all;
cd(cpath)