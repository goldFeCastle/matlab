% 기본 동작 코드 -- 건들지 말것!!
function varargout = FFTDetection(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FFTDetection_OpeningFcn, ...
                   'gui_OutputFcn',  @FFTDetection_OutputFcn, ...
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
% 기본 동작 코드 -- 건들지 말것!!


% 프로그램 시행시 최초로 동작하는 코드-로고 디스플레이,기본동작 지정
function FFTDetection_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
Logo=imread('Logo.png');
axes(handles.Logo_Display);imshow(Logo);
% 
axes(handles.Dopper_Raw_Graph);cla;
axes(handles.Dopper_Raw_Graph1);cla;
axes(handles.Dopper_Graph1);cla;
axes(handles.Dopper_Graph2);cla;
axes(handles.Spectrum_Graph1);cla;
axes(handles.Spectrum_Graph2);cla;
axes(handles.Spectrum_Graph3);cla;
axes(handles.Spectrum_Graph4);cla;
axes(handles.Spectrum_Graph5);cla;
% 
handles.output = hObject;
guidata(hObject, handles);

function varargout = FFTDetection_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in Spectrum_select.
function Spectrum_select_Callback(hObject, eventdata, handles)
axes(handles.Spectrum_Graph1);gca;cla;
axes(handles.Spectrum_Graph2);gca;cla;
axes(handles.Spectrum_Graph3);gca;cla;
axes(handles.Spectrum_Graph4);gca;cla;
axes(handles.Spectrum_Graph5);gca;cla;

[fileName, pathname, filterIndex] =  uigetfile({'*.csv', 'Comma Separated Values (*.csv)'},'Select Comma Separated Values','MultiSelect', 'on');
File_num_r = size(fileName);
File_num = File_num_r(1,2);
R_index = 0;    
C_index = 4;

Raw_N=char(fileName(1,1));
Raw=csvread(Raw_N,R_index,C_index);

if isequal(fileName,0)
    errordlg('취소','에러'); 
elseif File_num ~= 5
    errordlg('갯수 오류','에러');
end

Shift1=char(fileName(1,1));
Shift1_D=csvread(Shift1,R_index,C_index);

Shift2=char(fileName(1,2));
Shift2_D=csvread(Shift2,R_index,C_index);

Shift3=char(fileName(1,3));
Shift3_D=csvread(Shift3,R_index,C_index);

Shift4=char(fileName(1,4));
Shift4_D=csvread(Shift4,R_index,C_index);

Shift5=char(fileName(1,5));
Shift5_D=csvread(Shift5,R_index,C_index);

Time_table = csvread(Shift1,0,3);
TiMe = Time_table(:,1);
TiMe = Time_table(:,1)-min(TiMe);
TStep = TiMe(100,1)-TiMe(99,1);

    
    
       
    Magnitude1=length(Shift1_D);
    Freq_Range1 = 0:length(Shift1_D)-1;
    [AMP1,Freqency1,Freq_Vector1] = GFFT(Shift1_D,TStep,Magnitude1,Freq_Range1);

    axes(handles.Spectrum_Graph1);
    plot(Freqency1,AMP1,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [min(Freqency1) max(Freqency1)];ax.YLim = [min(AMP1) max(AMP1)*1.1];
    hold on;
    Max_freq1 = (find(AMP1 == max(AMP1))-1)/Freq_Vector1*(1e-6);
    set(handles.Spectrum_Freqency_number1,'String',Max_freq1);
    Max_posit1 =(find(AMP1 == max(AMP1))-1)/Freq_Vector1;
    plot(Max_posit1,max(AMP1),'rv','MarkerFaceColor','r');
    hold off;
    
    Magnitude2=length(Shift2_D);
    Freq_Range2 = 0:length(Shift2_D)-1;
    [AMP2,Freqency2,Freq_Vector2] = GFFT(Shift2_D,TStep,Magnitude2,Freq_Range2);

    axes(handles.Spectrum_Graph2);
    plot(Freqency2,AMP2,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [min(Freqency2) max(Freqency2)];ax.YLim = [min(AMP2) max(AMP2)*1.1];
    hold on;
    Max_freq2 = (find(AMP2 == max(AMP2))-1)/Freq_Vector2*(1e-6);
    set(handles.Spectrum_Freqency_number2,'String',Max_freq2);
    Max_posit2 = (find(AMP2 == max(AMP2))-1)/Freq_Vector1;
    plot(Max_posit2,max(AMP2),'rv','MarkerFaceColor','r');
    hold off;
    
    Magnitude3=length(Shift3_D);
    Freq_Range3 = 0:length(Shift3_D)-1;
    [AMP3,Freqency3,Freq_Vector3] = GFFT(Shift3_D,TStep,Magnitude3,Freq_Range3);

    axes(handles.Spectrum_Graph3);
    plot(Freqency3,AMP3,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [min(Freqency3) max(Freqency3)];ax.YLim = [min(AMP3) max(AMP3)*1.1];
    hold on;
    Max_freq3 = (find(AMP3 == max(AMP3))-1)/Freq_Vector3*(1e-6);
    set(handles.Spectrum_Freqency_number3,'String',Max_freq3);
    Max_posit3 = (find(AMP3 == max(AMP3))-1)/Freq_Vector3;
    plot(Max_posit3,max(AMP3),'rv','MarkerFaceColor','r');
    hold off;
    
    Magnitude4=length(Shift4_D);
    Freq_Range4 = 0:length(Shift4_D)-1;
    [AMP4,Freqency4,Freq_Vector4] = GFFT(Shift4_D,TStep,Magnitude4,Freq_Range4);

    axes(handles.Spectrum_Graph4);
    plot(Freqency4,AMP4,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [min(Freqency4) max(Freqency4)];ax.YLim = [min(AMP4) max(AMP4)*1.1];
    hold on;
    Max_freq4 = (find(AMP4 == max(AMP4))-1)/Freq_Vector4*(1e-6);
    set(handles.Spectrum_Freqency_number4,'String',Max_freq4);
    Max_posit4 = (find(AMP4 == max(AMP4))-1)/Freq_Vector4;
    plot(Max_posit4,max(AMP4),'rv','MarkerFaceColor','r');
    hold off;
    
    Magnitude5=length(Shift5_D);
    Freq_Range5 = 0:length(Shift5_D)-1;
    [AMP5,Freqency5,Freq_Vector5] = GFFT(Shift5_D,TStep,Magnitude5,Freq_Range5);

    axes(handles.Spectrum_Graph5);
    plot(Freqency5,AMP5,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [min(Freqency5) max(Freqency5)];ax.YLim = [min(AMP5) max(AMP5)*1.1];
    hold on;
    Max_freq5 = (find(AMP5 == max(AMP5)))/Freq_Vector5*(1e-6);
    set(handles.Spectrum_Freqency_number5,'String',Max_freq5);
    Max_posit5 = (find(AMP5 == max(AMP5)))/Freq_Vector1;
    plot(Max_posit5,max(AMP5),'rv','MarkerFaceColor','r');
    hold off;

% --- Executes on button press in Dopper_select.
function Dopper_select_Callback(hObject, eventdata, handles)
axes(handles.Dopper_Raw_Graph);gca;cla;
axes(handles.Dopper_Raw_Graph1);gca;cla;
axes(handles.Dopper_Graph1);gca;cla;
axes(handles.Dopper_Graph2);gca;cla;

[fileName, pathname, filterIndex] =  uigetfile({'*.csv', 'Comma Separated Values (*.csv)'},'Select Comma Separated Values','MultiSelect', 'on');
File_num_r = size(fileName)
File_num = File_num_r(1,2);
R_index = 0;    
C_index = 4;

if isequal(fileName,0)
    errordlg('취소','에러'); 
elseif File_num ~= 2
    errordlg('갯수 오류','에러');    
end

Shift1=char(fileName(1,1));
Shift1_D=csvread(Shift1,R_index,C_index);
Shift2=char(fileName(1,2));
Shift2_D=csvread(Shift2,R_index,C_index);

Time_table = csvread(Shift1,0,3);
TiMe = Time_table(:,1);
TiMe = Time_table(:,1)-min(TiMe);
TStep = TiMe(100,1)-TiMe(99,1);

set(handles.File_Name1,'String','Original');
set(handles.File_Name2,'String','Shift');

Ldata = length(Time_table(:,2));
axes(handles.Dopper_Raw_Graph);plot(Shift1_D,'K');
set(gca,'XTick','','YTick','')
Ylim1 = max(Shift1_D);  Ylim2 = min(Shift1_D);
ax = gca;    ax.XLim = [0 Ldata];    ax.YLim = [Ylim2*1.1 Ylim1*1.1];

axes(handles.Dopper_Raw_Graph1);plot(Shift2_D,'K');
set(gca,'XTick','','YTick','')
Ylim1 = max(Shift2_D);  Ylim2 = min(Shift2_D);
ax = gca;    ax.XLim = [0 Ldata];    ax.YLim = [Ylim2*1.1 Ylim1*1.1]; 

set(handles.text25,'String','Original Raw Signal');
set(handles.text25,'String','Shift Raw Signal');
axes(handles.Dopper_Raw_Graph);
    rect = getrect;     % position selecting
    Round = round(rect);    
    X1 = Round(1,1) ;        
    X2 = Round(1,3) ;       
    X3 = X1+X2;
    
    length(Shift1_D)
    SP1 = Shift1_D(X1:X3,1);
    SP2 = Shift2_D(X1:X3,1);% selected positon
    
    
    Magnitude1=length(SP1);
    Freq_Range1 = 0:length(SP1-1);
    [AMP1,Freqency1,Freq_Vector1] = GFFT(SP1,TStep,Magnitude1,Freq_Range1);
    Magnitude2=length(SP2);
    Freq_Range2 = 0:length(SP2-1);
    [AMP2,Freqency2,Freq_Vector2] = GFFT(SP2,TStep,Magnitude2,Freq_Range2);

    axes(handles.Dopper_Graph1);
    plot(Freqency1,AMP1,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [min(Freqency1) max(Freqency1)];ax.YLim = [min(AMP1) max(AMP1)*1.1];
    hold on;
    Max_freq1 = (find(AMP1 == max(AMP1))-1)/Freq_Vector1*(1e-6);
    set(handles.Dopper_Freqency_number2,'String',Max_freq1);
    Max_posit = (find(AMP1 == max(AMP1))-1)/Freq_Vector1;
    plot(Max_posit,max(AMP1),'rv','MarkerFaceColor','r');
    hold off;
    
    axes(handles.Dopper_Graph2);
    plot(Freqency2,AMP2,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [min(Freqency2) max(Freqency2)];ax.YLim = [min(AMP2) max(AMP2)*1.1];
    hold on;
    Max_freq2 = (find(AMP2 == max(AMP2))-1)/Freq_Vector2*(1e-6);
    set(handles.Dopper_Freqency_number3,'String',Max_freq2);
    Max_posit1 = (find(AMP2 == max(AMP2))-1)/Freq_Vector2;
    plot(Max_posit1,max(AMP2),'rv','MarkerFaceColor','r');
    hold off;
    
     if Max_freq2>Max_freq1
        Dopper_shift_f = (Max_freq2-Max_freq1)*1e+3;
    else
         Dopper_shift_f = (Max_freq1-Max_freq2)*1e+3;
    end
      cos_D = str2num(get(handles.Dopper_dergree_velue,'string'));
    DVelocity = (Dopper_shift_f*1540*100)/(2*Max_freq1*cosd(cos_D)*1000);
    set(handles.velocity_freq_1,'String',num2str(DVelocity));
    set(handles.DopperShift_freq,'String',num2str(Dopper_shift_f));
    set(handles.text25,'String','');
    


function Dopper_Freqency_number_Callback(hObject, eventdata, handles)
% hObject    handle to Dopper_Freqency_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dopper_Freqency_number as text
%        str2double(get(hObject,'String')) returns contents of Dopper_Freqency_number as a double


% --- Executes during object creation, after setting all properties.
function Dopper_Freqency_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dopper_Freqency_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dopper_Freqency_number2_Callback(hObject, eventdata, handles)
% hObject    handle to Dopper_Freqency_number2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dopper_Freqency_number2 as text
%        str2double(get(hObject,'String')) returns contents of Dopper_Freqency_number2 as a double


% --- Executes during object creation, after setting all properties.
function Dopper_Freqency_number2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dopper_Freqency_number2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dopper_Freqency_number3_Callback(hObject, eventdata, handles)
% hObject    handle to Dopper_Freqency_number3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dopper_Freqency_number3 as text
%        str2double(get(hObject,'String')) returns contents of Dopper_Freqency_number3 as a double


% --- Executes during object creation, after setting all properties.
function Dopper_Freqency_number3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dopper_Freqency_number3 (see GCBO)
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



function DopperShift_freq_Callback(hObject, eventdata, handles)
% hObject    handle to DopperShift_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DopperShift_freq as text
%        str2double(get(hObject,'String')) returns contents of DopperShift_freq as a double


% --- Executes during object creation, after setting all properties.
function DopperShift_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DopperShift_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function velocity_freq_1_Callback(hObject, eventdata, handles)
% hObject    handle to velocity_freq_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of velocity_freq_1 as text
%        str2double(get(hObject,'String')) returns contents of velocity_freq_1 as a double


% --- Executes during object creation, after setting all properties.
function velocity_freq_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to velocity_freq_1 (see GCBO)
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



function Spectrum_Freqency_number1_Callback(hObject, eventdata, handles)
% hObject    handle to Spectrum_Freqency_number1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Spectrum_Freqency_number1 as text
%        str2double(get(hObject,'String')) returns contents of Spectrum_Freqency_number1 as a double


% --- Executes during object creation, after setting all properties.
function Spectrum_Freqency_number1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spectrum_Freqency_number1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Spectrum_Freqency_number2_Callback(hObject, eventdata, handles)
% hObject    handle to Spectrum_Freqency_number2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Spectrum_Freqency_number2 as text
%        str2double(get(hObject,'String')) returns contents of Spectrum_Freqency_number2 as a double


% --- Executes during object creation, after setting all properties.
function Spectrum_Freqency_number2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spectrum_Freqency_number2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Spectrum_Freqency_number3_Callback(hObject, eventdata, handles)
% hObject    handle to Spectrum_Freqency_number3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Spectrum_Freqency_number3 as text
%        str2double(get(hObject,'String')) returns contents of Spectrum_Freqency_number3 as a double


% --- Executes during object creation, after setting all properties.
function Spectrum_Freqency_number3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spectrum_Freqency_number3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Spectrum_Freqency_number4_Callback(hObject, eventdata, handles)
% hObject    handle to Spectrum_Freqency_number4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Spectrum_Freqency_number4 as text
%        str2double(get(hObject,'String')) returns contents of Spectrum_Freqency_number4 as a double


% --- Executes during object creation, after setting all properties.
function Spectrum_Freqency_number4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spectrum_Freqency_number4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Spectrum_Freqency_number5_Callback(hObject, eventdata, handles)
% hObject    handle to Spectrum_Freqency_number5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Spectrum_Freqency_number5 as text
%        str2double(get(hObject,'String')) returns contents of Spectrum_Freqency_number5 as a double


% --- Executes during object creation, after setting all properties.
function Spectrum_Freqency_number5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spectrum_Freqency_number5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dopper_dergree_velue_Callback(hObject, eventdata, handles)
   cos_D = str2num(get(handles.Dopper_dergree_velue,'string'));
   Dopper_shift = str2num(get(handles.DopperShift_freq,'string'));
   Max_freq = str2num(get(handles.Dopper_Freqency_number2,'string'));
   DVelocity = (Dopper_shift*1540*100)/(2*Max_freq*cosd(cos_D)*1000);
   set(handles.velocity_freq_1,'String',num2str(DVelocity));


% --- Executes during object creation, after setting all properties.
function Dopper_dergree_velue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dopper_dergree_velue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
