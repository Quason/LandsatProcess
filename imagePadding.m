% Í¼ÏñÌî³ä
clc; clear; close all
cpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\S3_AutoHue\';
outpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\S4_AutoPadding\';
namelist=dir([cpath,'*.png']);
RGBbest=imread('C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\Best.png');
for i=1:length(namelist)
    if i<length(namelist)
        name1=namelist(i).name;
        name2=namelist(i+1).name;
        RGB1=imread([cpath,name1]);
        RGB2=imread([cpath,name2]);
        [n1,n2]=size(RGB1);
        nankey1=RGB1(:,:,1)==0 & RGB1(:,:,1)==0 & RGB1(:,:,1)==0;
        nankey2=RGB2(:,:,1)==0 & RGB2(:,:,1)==0 & RGB2(:,:,1)==0;
        key1=nankey1 & (~nankey2);
        key1=repmat(key1,1,1,3);
        key2=nankey1 & nankey2;
        key2=repmat(key2,1,1,3);
        RGB1(key1)=RGB2(key1);
        RGB1(key2)=RGBbest(key2);
    else
        name1=namelist(i).name;
        RGB1=imread([cpath,name1]);
        [n1,n2]=size(RGB1);
        nankey1=RGB1(:,:,1)==0 & RGB1(:,:,1)==0 & RGB1(:,:,1)==0;
        key2=repmat(nankey1,1,1,3);
        RGB1(key2)=RGBbest(key2);
    end
    imwrite(RGB1,[outpath,name1]);
end