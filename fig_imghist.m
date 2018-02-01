clear;clc;close all
cpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\S1_AutoClip\';
namelist=dir([cpath,'*_T1.png']);
autorito=5; % ½�ط�ֵ��ˮ���ֵ�Ĵ�ű���
for i=1:length(namelist)
    name=namelist(i).name;
    data=imread([cpath,name]);
    gray=rgb2gray(data);
    figure; imhist(gray);
    print([cpath,name(1:end-4),'_hist.png'],'-dpng','-r200');
    close all
end