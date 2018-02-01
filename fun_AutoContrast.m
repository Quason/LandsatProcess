function out=AutoContrast(Image)
% �Զ��Աȶ�
R=double(Image(:,:,1));
G=double(Image(:,:,2));
B=double(Image(:,:,3));
[row,col]=size(R);
% ��ø���ͨ���������Сֵ
percent=0.001;
Rsort=sort(R(:)); Gsort=sort(G(:)); Bsort=sort(B(:));
Rmin=Rsort(floor(row*col*percent)+1);
Rmax=Rsort(floor(row*col*(1-percent)));
Gmin=Gsort(floor(row*col*percent)+1);
Gmax=Gsort(floor(row*col*(1-percent)));
Bmin=Bsort(floor(row*col*percent)+1);
Bmax=Bsort(floor(row*col*(1-percent)));
% ���ͳһ�������Сֵ
Max=max([Rmax,Gmax,Bmax]);
Min=min([Rmin,Gmin,Bmin]);
% ɫ�ȵ���
R(R<Min)=0; R(R>Max)=255; R(R>=Min & R<=Max)=round((R(R>=Min & R<=Max)-Min)/(Max-Min)*255);
G(G<Min)=0; G(G>Max)=255; G(G>=Min & G<=Max)=round((G(G>=Min & G<=Max)-Min)/(Max-Min)*255);
B(B<Min)=0; B(B>Max)=255; B(B>=Min & B<=Max)=round((B(B>=Min & B<=Max)-Min)/(Max-Min)*255);
out(:,:,1)=R; out(:,:,2)=G; out(:,:,3)=B;
out=uint8(out);