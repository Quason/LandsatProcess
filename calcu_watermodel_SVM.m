% 用SVM模型进行训练建模
clc; clear; close all
cpath='C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\WaterSeparation\Model\';
namelist_RGB=dir([cpath,'*T1.png']);
R=[]; G=[]; B=[]; QB=[];
for i=1:length(namelist_RGB)
    nameRGB=namelist_RGB(i).name;
    nameQB=namelist_RGB(i).name;
    nameQB=[nameQB(1:end-4),'_WaterSegment.png'];
    RGBdata=imread([cpath,nameRGB]);
    QBdata=imread([cpath,nameQB]);
    Rt=RGBdata(:,:,1);
    Gt=RGBdata(:,:,2);
    Bt=RGBdata(:,:,3);
    [n1,n2]=size(Rt);
    R=[R;reshape(Rt,n1*n2,1)];
    G=[G;reshape(Gt,n1*n2,1)];
    B=[B;reshape(Bt,n1*n2,1)];
    QB=[QB;reshape(QBdata,n1*n2,1)];
end
res=[R,G,B,QB];
res(QB==0,:)=[];
res=res(1:100:end,:);
Model_Input=double(res(:,1:3));
Model_Target=double(res(:,4));

testRGBdata=imread('C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\WaterSeparation\Test\LC08_L1TP_120039_20140611_20170422_01_T1.png');
testQBdata=imread('C:\Users\cqy\Desktop\Job\FPI\Landsat\TaipingLack\WaterSeparation\Test\LC08_L1TP_120039_20140611_20170422_01_T1_WaterSegment.png');
Test_Input(:,1)=reshape(testRGBdata(:,:,1),n1*n2,1);
Test_Input(:,2)=reshape(testRGBdata(:,:,2),n1*n2,1);
Test_Input(:,3)=reshape(testRGBdata(:,:,3),n1*n2,1);
Test_Input=double(Test_Input);
Test_Target=reshape(testQBdata,n1*n2,1);
Model_label=ones(length(Model_Input),1);
Test_label=ones(length(Test_Input),1);

mystr='-s 0 -t 2 -h 0';
model=svmtrain(Model_Target,Model_Input,mystr);
Model_Output=svmpredict(Model_label,Model_Input,model);
Test_Output=svmpredict(Test_label,Test_Input,model);
%%
Test_Output_2D=reshape(Test_Output,n1,n2);