function res=LE7_PATCH(data)
[NL,NC]=size(data);
res=nan(NL,NC);
for nc=1:NC
    Ctemp=data(:,nc);
    x=(1:NL)';
    x1=x(~isnan(Ctemp));
    y1=Ctemp(~isnan(Ctemp));
    res(:,nc)=interp1(x1,y1,x);
end