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
% 如果噪声太明显需要进行滤波处理
if length(L1)>10
    cnt=medfilt1(cnt,2);
end
[~,L1]=findpeaks(cnt);
L1=L1-1; % 因为uint8是从0开始的
temp=cnt(L1(1):L1(end));
temp(temp<10)=nan;
[~,threshold]=nanmin(temp);
threshold=threshold+L1(1)-1;
threshold=(threshold+mintemp)/100;