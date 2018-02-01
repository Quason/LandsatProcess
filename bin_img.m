clear;clc;close all
cpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\S1_AutoClip\';
namelist=dir([cpath,'*_T1.png']);
autorito=5; % ½�ط�ֵ��ˮ���ֵ�Ĵ�ű���
for i=1:length(namelist)
    name=namelist(i).name;
    data=imread([cpath,name]);
    gray=rgb2gray(data);
    for j=1:255
        n_gray(j+1)=length(find(gray==j));
    end
    % ���ô���жϴ��µ���ֵ
    otsu=round(graythresh(gray)*255);
    % ����˫�巨��ȷ�ж�
    [~,peak1]=max(n_gray(2:otsu));
    [~,peak2]=max(n_gray(otsu+1:end));
    peak2=peak2+otsu;
    [~,dale]=min(n_gray(peak1:peak2));
    dale=dale+peak1-1; % ��ֵ
    % ��ֵ��
    figure
    bwimg=gray;
    bwimg(gray<dale & gray>0)=128;
    bwimg(gray>=dale)=255;
    bwimg=uint8(bwimg);
    imwrite(bwimg,[cpath,name(1:end-4),'_bin.png']);
    close all
end