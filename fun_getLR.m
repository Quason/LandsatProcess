function Lr=fun_getLR(tau,f0,SOLZ,SOLA,THV,PHV)
% 根据太阳和卫星传感器的位置信息计算大气瑞利散射
% Lr=fun_getLR(tau,f0,SOLZ,SOLA,THV,PHV)
phi=abs(PHV-SOLA-180);
if phi>360
    phi=phi-360;
end
if phi>180
    phi=phi-360;
end
raydata=hdfread('Rayleigh.dat', '/Radiance coef',...
    'Index',{[1 1 1 1 1],[1 1 1 1 1],[200 4 30 30 3]});
THV_list=hdfread('Rayleigh.dat', '/Sensor zenith angle',...
    'Index',{1,1,30});
tau_list=0.002:0.002:0.4;
SOLZ_list=0:3:87;
% 下标确定
tau_low=floor(tau/0.002);
if tau_low==0
    tau_low=1;
end
tau_high=tau_low+1;

SOLZ_low=floor(SOLZ/3)+1;
SOLZ_high=SOLZ_low+1;

if THV<=THV_list(1)
    THV_low=1;
else
    THV_low=find(THV_list>THV,1)-1;
end
THV_high=THV_low+1;
% 比例权重计算
htau=0.002;
hSOLZ=3;
hTHV=THV_list(THV_high)-THV_list(THV_low);
Wtau=(tau-tau_list(tau_low))/htau;
WSOLZ=(SOLZ-SOLZ_list(SOLZ_low))/hSOLZ;
if THV<=THV_list(1)
    WTHV=0;
else
    WTHV=(THV-THV_list(THV_low))/hTHV;
end
% 最终结果
ray_coef_I=nan(8,3);
ray_coef_I(1,:)=squeeze(raydata(tau_low,1,SOLZ_low,THV_low,:))';
ray_coef_I(2,:)=squeeze(raydata(tau_low,1,SOLZ_low,THV_high,:))';
ray_coef_I(3,:)=squeeze(raydata(tau_low,1,SOLZ_high,THV_low,:))';
ray_coef_I(4,:)=squeeze(raydata(tau_low,1,SOLZ_high,THV_high,:))';
ray_coef_I(5,:)=squeeze(raydata(tau_high,1,SOLZ_low,THV_low,:))';
ray_coef_I(6,:)=squeeze(raydata(tau_high,1,SOLZ_low,THV_high,:))';
ray_coef_I(7,:)=squeeze(raydata(tau_high,1,SOLZ_high,THV_low,:))';
ray_coef_I(8,:)=squeeze(raydata(tau_high,1,SOLZ_high,THV_high,:))';

ray_coef_1_I=nan(4,3);
ray_coef_1_I(1,:)=(1-WTHV)*ray_coef_I(1,:)+WTHV*ray_coef_I(2,:);
ray_coef_1_I(2,:)=(1-WTHV)*ray_coef_I(3,:)+WTHV*ray_coef_I(4,:);
ray_coef_1_I(3,:)=(1-WTHV)*ray_coef_I(5,:)+WTHV*ray_coef_I(6,:);
ray_coef_1_I(4,:)=(1-WTHV)*ray_coef_I(7,:)+WTHV*ray_coef_I(8,:);

ray_coef_2_I=nan(2,3);
ray_coef_2_I(1,:)=(1-WSOLZ)*ray_coef_1_I(1,:)+WSOLZ*ray_coef_1_I(2,:);
ray_coef_2_I(2,:)=(1-WSOLZ)*ray_coef_1_I(3,:)+WSOLZ*ray_coef_1_I(4,:);

ray_coef_3_I=(1-Wtau)*ray_coef_2_I(1,:)+Wtau*ray_coef_2_I(2,:);

ray_i=0;
for i=1:3
    ray_i=ray_i+ ray_coef_3_I(i)*cos(3.1415926*phi*i/180);
end
Lr=f0*ray_i;