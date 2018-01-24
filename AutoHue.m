clc;clear;close all
% 色彩校正
cpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\S2_AutoContrast\';
outpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\S3_AutoHue\';
namelist=dir([cpath,'*.png']);
for i=1:length(namelist)
    name=namelist(i).name;
    RGB=double(imread([cpath,name]));
    Rall(:,:,i)=RGB(:,:,1);
    Gall(:,:,i)=RGB(:,:,2);
    Ball(:,:,i)=RGB(:,:,3);
end
key=(Rall==0 & Gall==0 & Ball==0);
Rall(key)=nan; Gall(key)=nan; Ball(key)=nan;
Rmean=nanmean(Rall,3);
Gmean=nanmean(Gall,3);
Bmean=nanmean(Ball,3);
% 平均值
Rmean1D=squeeze(nanmean(nanmean(Rall,1),2));
Gmean1D=squeeze(nanmean(nanmean(Gall,1),2));
Bmean1D=squeeze(nanmean(nanmean(Ball,1),2));
Rmean_all=mean(Rmean1D);
Gmean_all=mean(Gmean1D);
Bmean_all=mean(Bmean1D);
% 相对偏差
ARE_r=abs(Rmean1D-mean(Rmean1D))/mean(Rmean1D);
ARE_g=abs(Gmean1D-mean(Gmean1D))/mean(Gmean1D);
ARE_b=abs(Bmean1D-mean(Bmean1D))/mean(Bmean1D);
for i=1:length(namelist)
    name=namelist(i).name;
    % Red
    if ARE_r(i)>0.3 && ARE_g(i)<=0.3
        Rmean1D_t=Rmean_all/Gmean_all*Gmean1D(i);
        Rall(:,:,i)=Rall(:,:,i)*(Rmean1D_t/Rmean1D(i));
        Bmean1D_t=Bmean_all/Gmean_all*Gmean1D(i);
        Ball(:,:,i)=Ball(:,:,i)*(Bmean1D_t/Bmean1D(i));
    elseif ARE_r(i)>0.3 && ARE_b(i)<=0.3
        Rmean1D_t=Rmean_all/Bmean_all*Bmean1D(i);
        Rall(:,:,i)=Rall(:,:,i)*(Rmean1D_t/Rmean1D(i));
        Gmean1D_t=Gmean_all/Bmean_all*Bmean1D(i);
        Gall(:,:,i)=Gall(:,:,i)*(Gmean1D_t/Gmean1D(i));
    end
    % Green
    if ARE_g(i)>0.3 && ARE_r(i)<=0.3
        Gmean1D_t=Gmean_all/Rmean_all*Rmean1D(i);
        Gall(:,:,i)=Gall(:,:,i)*(Gmean1D_t/Gmean1D(i));
        Bmean1D_t=Bmean_all/Rmean_all*Rmean1D(i);
        Ball(:,:,i)=Ball(:,:,i)*(Bmean1D_t/Bmean1D(i));
    elseif ARE_g(i)>0.3 && ARE_b(i)<=0.3
        Gmean1D_t=Gmean_all/Bmean_all*Bmean1D(i);
        Gall(:,:,i)=Gall(:,:,i)*(Gmean1D_t/Gmean1D(i));
        Rmean1D_t=Rmean_all/Bmean_all*Bmean1D(i);
        Rall(:,:,i)=Rall(:,:,i)*(Rmean1D_t/Rmean1D(i));
    end
    % Blue
    if ARE_b(i)>0.3 && ARE_r(i)<=0.3
        Bmean1D_t=Bmean_all/Rmean_all*Rmean1D(i);
        Ball(:,:,i)=Ball(:,:,i)*(Bmean1D_t/Bmean1D(i));
        Gmean1D_t=Gmean_all/Rmean_all*Rmean1D(i);
        Gall(:,:,i)=Gall(:,:,i)*(Gmean1D_t/Gmean1D(i));
    elseif ARE_b(i)>0.3 && ARE_g(i)<=0.3
        Bmean1D_t=Bmean_all/Gmean_all*Gmean1D(i);
        Ball(:,:,i)=Ball(:,:,i)*(Bmean1D_t/Bmean1D(i));
        Rmean1D_t=Rmean_all/Gmean_all*Gmean1D(i);
        Rall(:,:,i)=Rall(:,:,i)*(Rmean1D_t/Rmean1D(i));
    end
    out(:,:,1)=Rall(:,:,i);
    out(:,:,2)=Gall(:,:,i);
    out(:,:,3)=Ball(:,:,i);
    out=uint8(out);
    imwrite(out,[outpath,name]);
end