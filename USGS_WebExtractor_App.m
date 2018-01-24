function varargout = USGS_WebExtractor_App(varargin)
% USGS_WEBEXTRACTOR_APP MATLAB code for USGS_WebExtractor_App.fig
%      USGS_WEBEXTRACTOR_APP, by itself, creates a new USGS_WEBEXTRACTOR_APP or raises the existing
%      singleton*.
%
%      H = USGS_WEBEXTRACTOR_APP returns the handle to a new USGS_WEBEXTRACTOR_APP or the handle to
%      the existing singleton*.
%
%      USGS_WEBEXTRACTOR_APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USGS_WEBEXTRACTOR_APP.M with the given input arguments.
%
%      USGS_WEBEXTRACTOR_APP('Property','Value',...) creates a new USGS_WEBEXTRACTOR_APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before USGS_WebExtractor_App_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to USGS_WebExtractor_App_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help USGS_WebExtractor_App

% Last Modified by GUIDE v2.5 24-Jan-2018 17:24:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @USGS_WebExtractor_App_OpeningFcn, ...
                   'gui_OutputFcn',  @USGS_WebExtractor_App_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before USGS_WebExtractor_App is made visible.
function USGS_WebExtractor_App_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to USGS_WebExtractor_App (see VARARGIN)

% Choose default command line output for USGS_WebExtractor_App
% 不同分辨率电脑适配
set(0,'Units','normalized') %获得并将显示器显示设置为[0,0,1,1]的格式
f=gcf;%获得GUI句柄
set(f,'units','norm','position',[0.3 0.3 0.48 0.6]) % Set units to norm, and re-size.%将GUI的显示也设置为normalized，此时GUI内所有控件的单位都是normalized，同时设置起始位置.
h=get(gcf,'Children');%获取GUI的所有子Object，由于除了Object以外，字体单位也应该设置为normalized才能保持一致性
h1=findobj(h,'FontUnits','points');%找到所有的FontUnits'为points类型的Object（默认字体都是points类型的，如果你做了修改，这里就要改下了）
set(h1,'FontUnits','norm');%所有FontUnits都设置为normalized

global Global_stop;
Global_stop=0;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes USGS_WebExtractor_App wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = USGS_WebExtractor_App_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
handles=guihandles(gcbf);
choice=get(hObject,'Value');
if choice==1
    set(handles.radiobutton2,'Value',0);
    set(handles.edit7,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.edit8,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.edit9,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.edit10,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.text7,'ForegroundColor',[0.83 0.82 0.78]);
    set(handles.text8,'ForegroundColor',[0.83 0.82 0.78]);
    set(handles.text9,'ForegroundColor',[0.83 0.82 0.78]);
    set(handles.text10,'ForegroundColor',[0.83 0.82 0.78]);
    set(handles.edit1,'BackgroundColor','w');
    set(handles.edit4,'BackgroundColor','w');
    set(handles.edit5,'BackgroundColor','w');
    set(handles.edit6,'BackgroundColor','w');
    set(handles.text2,'ForegroundColor','k');
    set(handles.text3,'ForegroundColor','k');
    set(handles.text5,'ForegroundColor','k');
    set(handles.text6,'ForegroundColor','k');
end

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guihandles(gcbf);
choice=get(hObject,'Value');
if choice==1
    set(handles.radiobutton1,'Value',0);
    set(handles.edit7,'BackgroundColor','w');
    set(handles.edit8,'BackgroundColor','w');
    set(handles.edit9,'BackgroundColor','w');
    set(handles.edit10,'BackgroundColor','w');
    set(handles.text7,'ForegroundColor','k');
    set(handles.text8,'ForegroundColor','k');
    set(handles.text9,'ForegroundColor','k');
    set(handles.text10,'ForegroundColor','k');
    set(handles.edit1,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.edit4,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.edit5,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.edit6,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.text2,'ForegroundColor',[0.83 0.82 0.78]);
    set(handles.text3,'ForegroundColor',[0.83 0.82 0.78]);
    set(handles.text5,'ForegroundColor',[0.83 0.82 0.78]);
    set(handles.text6,'ForegroundColor',[0.83 0.82 0.78]);
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton2




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 网页信息抓包器
% 数据基本信息
handles=guihandles(gcbf); % 为了获取子当前图像窗口的句柄避免执行不了createFunction
global Global_stop;
Global_stop=0;
set(handles.edit14,'Visible','on');
set(handles.pushbutton1,'foregroundcolor',[0.8 0.8 0.8]);
set(handles.pushbutton2,'foregroundcolor','k');
if get(handles.radiobutton1,'Value')==1 && get(handles.radiobutton2,'Value')==0
    % 按照行列号范围查找
    start_path=get(handles.edit1,'String');
    end_path=get(handles.edit4,'String');
    start_row=get(handles.edit5,'String');
    end_row=get(handles.edit6,'String');
    if isnan(str2double(start_path))||isnan(str2double(end_path))||isnan(str2double(start_row))||isnan(str2double(end_row))
        error('请按照正确的格式输入Path/Row范围');
    end
elseif get(handles.radiobutton1,'Value')==0 && get(handles.radiobutton2,'Value')==1
    % 按照经纬度范围查找
    lon_east=get(handles.edit1,'String');
    lon_west=get(handles.edit4,'String');
    lat_south=get(handles.edit5,'String');
    lat_north=get(handles.edit6,'String');
    if isnan(str2double(lon_east))||isnan(str2double(lon_west))||isnan(str2double(lat_south))||isnan(str2double(lat_north))
        error('请按照正确的格式输入经纬度范围');
    end
else
    error('请按照正确的格式输入空间范围');
end
startDate=get(handles.edit12,'String');
endDate=get(handles.edit13,'String');
% 传感器类型
SensorList={'LANDSAT_8_C1','LANDSAT_ETM_C1','LANDSAT_TM_C1'};
sensorN=get(handles.popupmenu1,'Value');
sensor=SensorList{sensorN}; 
% 云量选择(<=threshold)
cloudCoverLim=get(handles.edit11,'String');
if strcmp(cloudCoverLim(end),'%')
    cloudCoverLim=str2double(cloudCoverLim(1:end-1));
else
    error('请按照正确的格式输入云量范围(0%-100%)');
end
% 元数据获取
set(handles.edit14,'String','元数据获取……')
if get(handles.radiobutton1,'Value')==1
    URL=['https://earthexplorer.usgs.gov/EE/InventoryStream/pathrow?start_path=',...
        start_path,'&end_path=',end_path,'&start_row=',start_row,'&end_row=',end_row,...
        '&sensor=',sensor,'&start_date=',startDate,'&end_date=',endDate,'&format=CSV'];
else
    URL=['https://earthexplorer.usgs.gov/EE/InventoryStream/latlong?north=',...
    lat_south,'&south=',lat_north,'&east=',lon_east,'&west=',lon_west,...
    '&sensor=',sensor,'&start_date=',startDate,'&end_date=',endDate,'&format=CSV'];
end

urlwrite(URL,'tempURL.csv');
[data,URLstr]=xlsread('tempURL.csv');
for i=1:size(URLstr,2)
    if strcmp(URLstr{1,i},'cartURL')
        LocaURL=i;
    end
    if strcmp(URLstr{1,i},'cloudCoverFull')
        LocaCloud=i;
    end
end
URLstr=URLstr(2:end,LocaURL);
cloudCover=data(1:end,LocaCloud-7);
keyC=cloudCover<=cloudCoverLim;
URLstr=URLstr(keyC);
if exist('tempURL.csv','file')
    delete('tempURL.csv');
end
% 模拟交互
set(handles.edit14,'String','浏览器交互……')
ie=actxserver('internetexplorer.application');
cnt=length(URLstr);
resURL=cell(cnt,1);
for nn=1:cnt
    if Global_stop==1
        break
    end
    % 第一个页面
    url=URLstr{nn};
    ie.Navigate(url);
%     ie.Visible=1;
    tic
    while ~strcmp(ie.ReadyState,'READYSTATE_COMPLETE')
        pause(0.01)
        runtime=toc;
        if runtime>120
            error(['网址(',url,')无法访问,请检查网络连接情况和IE浏览器设置',])
        end
    end
    tempURL=[];
    pause(1)
    n=ie.document.links.length;
    for i=1:n
        if strcmp(get(ie.document.links.item(i),'innerHTML'),'<div class="ee-icon ee-icon-download"></div>')
            tempURL=get(ie.document.links.item(i),'outerHTML');
            break
        end
    end
    if ~isempty(tempURL)
        strloca=strfind(tempURL,'"');
        tempURL=tempURL(strloca(1)+1:strloca(2)-1);
    else
        warning(['URL获取失败，请检查以下网站（此消息可以忽略）: ',url]);
        continue
    end
    % 第二个页面
    ie.Navigate(tempURL);
    tic
    while ~strcmp(ie.ReadyState,'READYSTATE_COMPLETE')
        pause(0.1)
        runtime=toc;
        if runtime>120
            error(['网址(',tempURL,')无法访问,请检查网络连接情况和IE浏览器设置',])
        end
    end
    buttonID=ie.document.body.getElementsByClassName('row clearfix');
    Nclearfix=buttonID.length;
    if Nclearfix~=5
        warning(['URL获取失败，请检查以下网站（此消息可以忽略）: ',tempURL]);
        continue % 先不管，继续查找下一个
    end
    key=0;
    for i=1:Nclearfix
        innerText=get(buttonID.item(i),'innerText');
        if ~isempty(strfind(innerText,'Level-1 GeoTIFF Data Product'))
            tempURL=get(buttonID.item(i),'outerHTML');
            key=1;
            break
        end
    end
    if key==0
        warning(['URL获取失败，请检查以下网站（此消息可以忽略）: ',tempURL]);
        continue % 先不管，继续查找下一个
    else
        loca=strfind(tempURL,'https://');
        loca2=strfind(tempURL,'/EE');
        resURL{nn,1}=tempURL(loca:loca2+2);
    end
    set(handles.edit14,'String',['第',num2str(nn),'个链接生成完毕!(共',num2str(cnt),'个)']);
end
fid=fopen('outputURL.txt','w');
for i=1:length(resURL)
    fprintf(fid,'%s\r\n',resURL{i});
end
fclose(fid);
delete(ie)
set(handles.pushbutton1,'foregroundcolor','k');
set(handles.pushbutton2,'foregroundcolor',[0.8 0.8 0.8]);
msgbox('执行完毕，结果保存在outputURL.txt中','End');


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit13.
function edit13_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function text9_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to text9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global Global_stop;
Global_stop=1;
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes(hObject)
[data,map,alpha]=imread('logo.png');
h=imshow(data);
set(h,'AlphaData',alpha)
% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function text17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


