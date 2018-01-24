clc; clear; close all
% 自动色调
cpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\S4_AutoPadding\';
outpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\img\final\';
namelist=dir([cpath,'*.png']);
for i=1:length(namelist)
    out=[];
    name=namelist(i).name;
    Image=imread([cpath,name]);
    R=double(Image(:,:,1));
    G=double(Image(:,:,2));
    B=double(Image(:,:,3));
    [row,col]=size(R);
    % 获得各个通道的最大最小值
    percent=0.001;
    Rsort=sort(R(:)); Gsort=sort(G(:)); Bsort=sort(B(:));
    Rmin=Rsort(floor(row*col*percent)+1);
    Rmax=Rsort(floor(row*col*(1-percent)));
    Gmin=Gsort(floor(row*col*percent)+1);
    Gmax=Gsort(floor(row*col*(1-percent)));
    Bmin=Bsort(floor(row*col*percent)+1);
    Bmax=Bsort(floor(row*col*(1-percent)));
    % 色度调整
    R(R<Rmin)=0; R(R>Rmax)=255; R(R>=Rmin & R<=Rmax)=round((R(R>=Rmin & R<=Rmax)-Rmin)/(Rmax-Rmin)*255);
    G(G<Gmin)=0; G(G>Gmax)=255; G(G>=Gmin & G<=Gmax)=round((G(G>=Gmin & G<=Gmax)-Gmin)/(Gmax-Gmin)*255);
    B(B<Bmin)=0; B(B>Bmax)=255; B(B>=Bmin & B<=Bmax)=round((B(B>=Bmin & B<=Bmax)-Bmin)/(Bmax-Bmin)*255);
    out(:,:,1)=R; out(:,:,2)=G; out(:,:,3)=B;
    out=uint8(out);
    imwrite(out,[outpath,name]);
end