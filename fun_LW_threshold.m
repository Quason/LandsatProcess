function threshold=LW_threshold(NDWI)
percent=0.001;
res_useful=sort(NDWI(:));
res_useful(isnan(res_useful)|res_useful==-1|res_useful==1)=[];
cnt=length(res_useful);
res_useful=res_useful(floor(cnt*percent)+1:floor(cnt*(1-percent))+1);
res_useful=round(res_useful*100);
mintemp=min(res_useful(:));
res_useful=res_useful-mintemp;
cnt=imhist(uint8(res_useful)); % 0-255
[~,L1]=findpeaks(cnt);
% �������̫������Ҫ�����˲�����
if length(L1)>10
    cnt=medfilt1(cnt,2);
end
[~,L1]=findpeaks(cnt);
L1=L1-1; % ��Ϊuint8�Ǵ�0��ʼ��
temp=cnt(L1(1):L1(end));
temp(temp<10)=nan;
[~,threshold]=nanmin(temp);
threshold=threshold+L1(1)-1;
threshold=(threshold+mintemp)/100;