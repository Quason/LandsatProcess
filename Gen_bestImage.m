% 生成多年融合的样例图像
clc; clear; close all
cpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\BestImage\';
outpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\BestImage\';
namelist=dir([cpath,'*.png']);
for i=1:length(namelist)
    name=namelist(i).name;
    RGB=double(imread([cpath,name]));
    R(:,:,i)=RGB(:,:,1);
    G(:,:,i)=RGB(:,:,2);
    B(:,:,i)=RGB(:,:,3);
end
key=(R==0&G==0&B==0);
R(key)=nan; G(key)=nan; B(key)=nan;
R=nanmean(R,3); G=nanmean(G,3); B=nanmean(B,3);
out(:,:,1)=R; out(:,:,2)=G; out(:,:,3)=B;
out=uint8(out);
imwrite(out,[outpath,'Best.png']);