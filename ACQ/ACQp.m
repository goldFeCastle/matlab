function varargout = ACQp(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ACQp_OpeningFcn, ...
                   'gui_OutputFcn',  @ACQp_OutputFcn, ...
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

function ACQp_OpeningFcn(hObject, eventdata, handles, varargin)

clc; 

RI = fopen('InitialSetting.txt','r');
handles.Init=fscanf(RI,'%g %g %g %g %g %g %g',[1,7]);
fclose(RI);

set(handles.RowDATA,'Value',handles.Init(1,1));
set(handles.ColumnDATA,'Value',handles.Init(1,2));
set(handles.Ph_P,'Value',handles.Init(1,3));
set(handles.Wa_P,'Value',handles.Init(1,4));

axes(handles.axes1);cla;
axes(handles.axes2);cla;
axes(handles.axes3);cla;
axes(handles.axes4);cla;
axes(handles.axes5);cla;
axes(handles.axes6);cla;
axes(handles.axes7);cla;
axes(handles.axes11);cla;
axes(handles.axes12);cla;
axes(handles.axes13);cla;
axes(handles.axes14);cla;
% 

set(handles.Wa_P,'enable','off');
set(handles.Ph_P,'enable','off');
% 
set(handles.uitable1,'data',{0 0 0 0 0});
%
Logo=imread('Logo.png');
axes(handles.axes16);imshow(Logo);

handles.output = hObject;

guidata(hObject, handles);

function varargout = ACQp_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function ACQp_SizeChangedFcn(hObject, eventdata, handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dT_B_Callback(hObject, eventdata, handles)


axes(handles.axes11);gca; cla;
axes(handles.axes12);gca; cla;
axes(handles.axes13);gca; cla;
axes(handles.axes14);gca; cla;
axes(handles.axes1);gca; cla;


[fileName, pathname, filterIndex] =  uigetfile({ ...
        '*.csv', 'Comma Separated Values (*.csv)'}, ...
        'Select Comma Separated Values','MultiSelect', 'on');
    
    A = get(handles.Ph_P,'Value');
    AA = size(fileName);
    AA = AA(1,2);    
    RA = get(handles.RowDATA,'Value')-1;    
    CA = get(handles.ColumnDATA,'Value')-1;
    
    BB=char(fileName(1,1));
    BB=csvread(BB,RA,CA);
    BBB=length(BB)-5;
        
if isequal(fileName,0)
    errordlg('취소냐?','에러다'); 
elseif AA ~= A
    errordlg('갯수는 맞추자','에러다');    
else
    for C=1:AA
    BB = char(fileName(1,C))
    handles.fileName = BB;
    CC = csvread(BB,RA,CA);   
    CC = CC(1:BBB,1);
    DD(C,:)=CC;
    end
end


set(handles.FNT,'String',char(fileName(1,1)));     set(handles.FNT6,'String',char(fileName(1,2)));     set(handles.FNT7,'String',char(fileName(1,3))); 
set(handles.FNT8,'String',char(fileName(1,4)));     set(handles.FNT9,'String',char(fileName(1,5))); 
%
handles.FNTU = char(fileName(1,1));
%


EE = char(fileName(1,1));
FF = csvread(EE,0,3);
TiMe = FF(:,1); 
TStep = TiMe(100,1)-TiMe(99,1);
Fs = num2str(1e-06/TStep);
SFT = ['Sampling Freq :  ', Fs, '  MHz' ]; set(handles.SFT,'String',SFT);
Ldata = length(FF(:,2));

axes(handles.axes1); plot(DD(1, : ),'K');
set(gca,'XTick','','YTick','')
Ylim1 = max(DD(1,:));  Ylim2 = min(DD(1,:));
ax = gca;    ax.XLim = [0 Ldata];    ax.YLim = [Ylim2*1.1 Ylim1*1.1]; 

axes(handles.axes11); plot(DD(2, : ),'K');
set(gca,'XTick','','YTick','')
Ylim1 = max(DD(2, : ));  Ylim2 = min(DD(2, : ));
ax = gca;    ax.XLim = [0 Ldata];    ax.YLim = [Ylim2*1.1 Ylim1*1.1];

axes(handles.axes12); plot(DD(3, : ),'K');
set(gca,'XTick','','YTick','')
Ylim1 = max(DD(3, : ));  Ylim2 = min(DD(3, : ));
ax = gca;    ax.XLim = [0 Ldata];    ax.YLim = [Ylim2*1.1 Ylim1*1.1];

axes(handles.axes13); plot(DD(4, : ),'K');
set(gca,'XTick','','YTick','')
Ylim1 = max(DD(4, : ));  Ylim2 = min(DD(4, : ));
ax = gca;    ax.XLim = [0 Ldata];    ax.YLim = [Ylim2*1.1 Ylim1*1.1];

axes(handles.axes14); plot(DD(5, : ),'K');
set(gca,'XTick','','YTick','')
Ylim1 = max(DD(5, : ));  Ylim2 = min(DD(5, : ));
ax = gca;    ax.XLim = [0 Ldata];    ax.YLim = [Ylim2*1.1 Ylim1*1.1];


axes(handles.axes1);
    rect = getrect;     % position selecting
    Round = round(rect);    
    X1 = Round(1,1);         
    X2 = Round(1,3);        
    X3 = X1+X2;     
    SP = DD(1,X1:X3); % selected positon
    plot(SP,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [0 length(SP)];
    SP = detrend(SP);
    LSP = length(SP); %length of selected position
    LSP1 = mod(LSP,2); % even odd
    
    if LSP1 == 1 % divide a SP
       LDSP1 = SP(1:(LSP-1)/2);     LDSP2 = SP((LSP-1)/2+1:LSP);
    else
       LDSP1 = SP(1:LSP/2);         LDSP2 = SP(LSP/2+1:LSP);  
    end
    
    set(handles.dTVp1,'String',round(peak2peak(LDSP1),4));
    set(handles.dTVp2,'String',round(peak2peak(LDSP2),4));    
    
    [MaxV1,MaxL1] = max(LDSP1(:));    [MinV1,MinL1] = min(LDSP1(:));
    [MaxV2,MaxL2] = max(LDSP2(:));    [MinV2,MinL2] = min(LDSP2(:)); 
    
     if abs(MaxV1) < abs(MinV1)
         MaxL1 = MinL1;         MaxV1 = MinV1;
     end
     if abs(MaxV2) < abs(MinV2)
         MaxL2 = MinL2;         MaxV2 = MinV2;
     end     
    hold on
        plot(MaxL1,MaxV1*1.2,'rv','MarkerFaceColor','r'); %Vpp
        plot(MaxL2+length(LDSP1),MaxV2,'rv','MarkerFaceColor','r');
   hold off    
    
   DT(1,1) = round((MaxL2+length(LDSP1)-MaxL1)*TStep*10^6,4);
   set(handles.dTT,'String',DT(1,1));    
    
    
axes(handles.axes11);    
    SP1 = DD(2,X1:X3);
    SP1 = detrend(SP1);
    plot(SP1,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [0 length(SP1)]; 
    
        LSP = length(SP); %length of selected position
    LSP1 = mod(LSP,2); % even odd
    
    if LSP1 == 1 % divide a SP
       LDSP1 = SP1(1:(LSP-1)/2);     LDSP2 = SP1((LSP-1)/2+1:LSP);
    else
       LDSP1 = SP1(1:LSP/2);         LDSP2 = SP1(LSP/2+1:LSP);  
    end
    
    
    [MaxV1,MaxL1] = max(LDSP1(:));    [MinV1,MinL1] = min(LDSP1(:));
    [MaxV2,MaxL2] = max(LDSP2(:));    [MinV2,MinL2] = min(LDSP2(:)); 
    
     if abs(MaxV1) < abs(MinV1)
         MaxL1 = MinL1;         MaxV1 = MinV1;
     end
     if abs(MaxV2) < abs(MinV2)
         MaxL2 = MinL2;         MaxV2 = MinV2;
     end     
    hold on
        plot(MaxL1,MaxV1*1.2,'rv','MarkerFaceColor','r'); %Vpp
        plot(MaxL2+length(LDSP1),MaxV2,'rv','MarkerFaceColor','r');
   hold off    
    
   DT(2,1) = round((MaxL2+length(LDSP1)-MaxL1)*TStep*10^6,4);
   set(handles.dTT1,'String',DT(2,1))
    
axes(handles.axes12);
    SP2 = DD(3,X1:X3);
    SP2 = detrend(SP2);
    plot(SP2,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [0 length(SP2)]; 
    
    LSP = length(SP); %length of selected position
    LSP1 = mod(LSP,2); % even odd
    
    if LSP1 == 1 % divide a SP
       LDSP1 = SP2(1:(LSP-1)/2);     LDSP2 = SP2((LSP-1)/2+1:LSP);
    else
       LDSP1 = SP2(1:LSP/2);         LDSP2 = SP2(LSP/2+1:LSP);  
    end
    
    
    [MaxV1,MaxL1] = max(LDSP1(:));    [MinV1,MinL1] = min(LDSP1(:));
    [MaxV2,MaxL2] = max(LDSP2(:));    [MinV2,MinL2] = min(LDSP2(:)); 
    
     if abs(MaxV1) < abs(MinV1)
         MaxL1 = MinL1;         MaxV1 = MinV1;
     end
     if abs(MaxV2) < abs(MinV2)
         MaxL2 = MinL2;         MaxV2 = MinV2;
     end     
    hold on
        plot(MaxL1,MaxV1*1.2,'rv','MarkerFaceColor','r'); %Vpp
        plot(MaxL2+length(LDSP1),MaxV2,'rv','MarkerFaceColor','r');
   hold off    
    
   DT(3,1) = round((MaxL2+length(LDSP1)-MaxL1)*TStep*10^6,4);
   set(handles.dTT2,'String',DT(3,1));       
 
   
axes(handles.axes13);
    SP3 = DD(4,X1:X3);
    SP3 = detrend(SP3);
    plot(SP3,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [0 length(SP3)];  
    
    LSP = length(SP); %length of selected position
    LSP1 = mod(LSP,2); % even odd
    
    if LSP1 == 1 % divide a SP
       LDSP1 = SP3(1:(LSP-1)/2);     LDSP2 = SP3((LSP-1)/2+1:LSP);
    else
       LDSP1 = SP3(1:LSP/2);         LDSP2 = SP3(LSP/2+1:LSP);  
    end
    
    
    [MaxV1,MaxL1] = max(LDSP1(:));    [MinV1,MinL1] = min(LDSP1(:));
    [MaxV2,MaxL2] = max(LDSP2(:));    [MinV2,MinL2] = min(LDSP2(:)); 
    
     if abs(MaxV1) < abs(MinV1)
         MaxL1 = MinL1;         MaxV1 = MinV1;
     end
     if abs(MaxV2) < abs(MinV2)
         MaxL2 = MinL2;         MaxV2 = MinV2;
     end     
    hold on
        plot(MaxL1,MaxV1*1.2,'rv','MarkerFaceColor','r'); %Vpp
        plot(MaxL2+length(LDSP1),MaxV2,'rv','MarkerFaceColor','r');
   hold off    
    
   DT(4,1) = round((MaxL2+length(LDSP1)-MaxL1)*TStep*10^6,4);
   set(handles.dTT3,'String',DT(4,1));    
    
    
    
axes(handles.axes14); 
    SP4 = DD(5,X1:X3);
    SP4 = detrend(SP4);
    plot(SP4,'K');   set(gca,'XTick','','YTick','');
    ax = gca; ax.XLim = [0 length(SP)];   
    
    LSP = length(SP); %length of selected position
    LSP1 = mod(LSP,2); % even odd
    
    if LSP1 == 1 % divide a SP
       LDSP1 = SP4(1:(LSP-1)/2);     LDSP2 = SP4((LSP-1)/2+1:LSP);
    else
       LDSP1 = SP4(1:LSP/2);         LDSP2 = SP4(LSP/2+1:LSP);  
    end
    
    
    [MaxV1,MaxL1] = max(LDSP1(:));    [MinV1,MinL1] = min(LDSP1(:));
    [MaxV2,MaxL2] = max(LDSP2(:));    [MinV2,MinL2] = min(LDSP2(:)); 
    
     if abs(MaxV1) < abs(MinV1)
         MaxL1 = MinL1;         MaxV1 = MinV1;
     end
     if abs(MaxV2) < abs(MinV2)
         MaxL2 = MinL2;         MaxV2 = MinV2;
     end     
    hold on
        plot(MaxL1,MaxV1*1.2,'rv','MarkerFaceColor','r'); %Vpp
        plot(MaxL2+length(LDSP1),MaxV2,'rv','MarkerFaceColor','r');
   hold off    
    
   DT(5,1) = round((MaxL2+length(LDSP1)-MaxL1)*TStep*10^6,4);
   set(handles.dTT4,'String',DT(5,1));    
    AC=size(DT);

DT1=(DT(1,1)+DT(2,1)+DT(3,1)+DT(4,1)+DT(5,1))/AC(1,1);

set(handles.AvrdT,'String',round(DT1,4));

handles.DTU = DT1;
handles.DT = DT;

     guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pToP_B_Callback(hObject, eventdata, handles)
axes(handles.axes1);gca; cla

[fileName, pathname, ~] =  uigetfile(...
                         {'*.csv', 'Comma Separated Values (*.csv)'},...
                         'Select Comma Separated Values');
if isequal(fileName,0)
   errordlg('하나는 선택하자','Error');
else
    CroppedA = csvread(fileName,5,0);	SigA = CroppedA(:,2);	Ldata = length(SigA);    
    
    axes(handles.axes1); plot(CroppedA,'K');
    set(gca,'XTick','','YTick','')
	Ylim1 = max(SigA);  Ylim2 = min(SigA);
    ax = gca;    ax.XLim = [0 Ldata];    ax.YLim = [Ylim2*1.1 Ylim1*1.1];  

    rect = getrect;     % position selecting
    Round = round(rect);    X1 = Round(1,1);         X2 = Round(1,3);        X3 = X1+X2;
    SP = SigA(X1:X3,:); % selected positon

    axes(handles.axes2);	plot(SP,'K');% raw data display    
    set(gca,'XTick','','YTick','')
    YlmSP = max(SP)*1.3;    YlmSP1 = min(SP)*1.3;
    ax = gca;    ax.YLim = [YlmSP1 YlmSP];    ax.XLim = [0 length(SP)];

% %     Vpp1 = round(peak2peak(LDSP1),4);
% %     Vpp2 = round(peak2peak(LDSP2),4);
    [MaxV1,MaxL1] = max(SP(:));    [MinV1,MinL1] = min(SP(:));
     
     
    hold on
        plot(MaxL1,MaxV1,'rv','MarkerFaceColor','r'); %Vpp
        plot(MinL1,MinV1,'^','MarkerFaceColor','r'); %Vpp
   hold off
   
   P2P = round(peak2peak(SP),4);
   set(handles.dTVp1,'String',P2P);
end
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function aW_B_Callback(hObject, eventdata, handles)
axes(handles.axes1);gca; cla

[fileName, pathname, filterIndex] =  uigetfile({ ...
        '*.csv', 'Comma Separated Values (*.csv)'}, ...
        'Select Comma Separated Values','MultiSelect', 'on');
    
A = get(handles.Wa_P,'Value');
AA = size(fileName);
AA = AA(1,2);

FNT = ['Filename :  ', char(fileName(1,1))]; set(handles.FNT,'String',FNT); SFT = ['Filename :  ', char(fileName(1,2)) ]; set(handles.SFT,'String',SFT);      

if isequal(fileName,0)
    errordlg('하나는 선택하자','Error'); 
elseif AA ~= A
    errordlg('갯수 맞추자','Error');    
else
    for C=1:AA
     BB = char(fileName(1,C));
     CC = csvread(BB,0,4);
     CC = CC(:,1);
     DD(C,:) = CC;
    end
 
end
	AA = DD(1,:);
    BB = DD(2,:); 
    Ylim2 = min(AA);
    BBB = BB+max(AA);
    Ylim1 = max(BBB);    
    axes(handles.axes1);    hold on;	plot(AA,'K');	plot(BBB,'r');
    hold off
    LSP = length(AA);
    ax = gca;
    ax.XLim = [0 LSP];
    ax.YLim = [Ylim2*1.1 Ylim1*1.1];

    rect = getrect;     % position selecting
    Round = round(rect);
    X1 = Round(1,1);
    X2 = Round(1,3);
    X3 = X1+X2;
    SP1 = DD(1,X1:X3); % selected data
    SP2 = DD(2,X1:X3);
    LSP = length(SP1); %length of selected position

    handles.X1 = X1;
    handles.X3 = X3;
    axes(handles.axes2); plot(SP1,'K');
    set(gca,'XTick','','YTick','')
    ax = gca;
    ax.XLim = [0 LSP];
    axes(handles.axes3); plot(SP2,'K');
    set(gca,'XTick','','YTick','')
    ax = gca;
    ax.XLim = [0 LSP];
    handles.LSP = LSP;
    M1(1,1) = round(peak2peak(SP1),4);
    M1(2,1) = round(peak2peak(SP2),4);    
    set(handles.Vpp1,'String',M1(1,1));
    set(handles.Vpp2,'String',M1(2,1));
    handles.M1 = M1;
    GG = (M1(1,1)+M1(2,1))/2;
    set(handles.AVp1,'String',GG);
    handles.ASD = GG;
    handles.Vp1U = GG; 
    guidata(hObject,handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function aP_B_Callback(hObject, eventdata, handles)

[fileName, pathname, filterIndex] =  uigetfile({ ...
        '*.csv', 'Comma Separated Values (*.csv)'}, ...
        'Select Comma Separated Values','MultiSelect', 'on');
    
A = get(handles.Ph_P,'Value');
AA = size(fileName);
AA = AA(1,2);
        
if isequal(fileName,0)
    errordlg('하나는 선택하자','Error'); 
elseif AA ~= A
    errordlg('갯수는 맞추자','Error');    
else
    for C=1:AA
     BB = char(fileName(1,C));
     CC = csvread(BB,0,4);
     CC = CC(:,1);
     DD(C,:) = CC;
    end  
end

set(handles.FNT1,'String',char(fileName(1,1)));     set(handles.FNT2,'String',char(fileName(1,2)));     set(handles.FNT3,'String',char(fileName(1,3))); 
set(handles.FNT4,'String',char(fileName(1,4)));     set(handles.FNT5,'String',char(fileName(1,5))); 


	LSP = handles.LSP;

    AA = DD(1, handles.X1:handles.X3);
    axes(handles.axes4);plot(AA,'K');
    set(gca,'XTick','','YTick','')
    ax = gca; ax.XLim = [0 LSP];
    set(handles.Vpp3,'String',round(peak2peak(AA),4));
    ABCDE(1,1) = peak2peak(AA);

    
    BB = DD(2, handles.X1:handles.X3);    
    axes(handles.axes5);plot(BB,'K');
    set(gca,'XTick','','YTick','')    
    ax = gca; ax.XLim = [0 LSP]; 
    set(handles.Vpp4,'String',round(peak2peak(BB),4));
    ABCDE(2,1) = peak2peak(BB);

    
    CC = DD(3, handles.X1:handles.X3);
    axes(handles.axes6);plot(CC,'K');
    set(gca,'XTick','','YTick','')    
    ax = gca; ax.XLim = [0 LSP];
    set(handles.Vpp5,'String',round(peak2peak(CC),4));
    ABCDE(3,1) = peak2peak(CC);

    
    EE = DD(4, handles.X1:handles.X3);
    axes(handles.axes7);plot(EE,'K');
    set(gca,'XTick','','YTick','')    
    ax = gca; ax.XLim = [0 LSP]; 
    set(handles.Vpp6,'String',round(peak2peak(EE),4)); 
    ABCDE(4,1) = peak2peak(EE);

    
    FF = DD(5, handles.X1:handles.X3);
    axes(handles.axes8);plot(FF,'K');
    set(gca,'XTick','','YTick','')    
    ax = gca; ax.XLim = [0 LSP];
    set(handles.Vpp7,'String',round(peak2peak(FF),4));
    ABCDE(5,1) = peak2peak(FF);
    handles.ABCDE = ABCDE;
    GG = round((peak2peak(AA)+peak2peak(BB)+peak2peak(CC)+peak2peak(EE)+peak2peak(FF))/5,4);
    set(handles.AVp2,'String',GG);
 
     HH = handles.ASD;
     TrF = str2double(get(handles.TrF,'String'));
    PhH = str2double(get(handles.PhH,'String'));

     
  %%%%%%%%%%% 수정필요 %%%%%%%%%%%%   
     alp(1,1) = (-(20/(2*PhH))*(log10(peak2peak(AA)/HH))/TrF);
     alp(2,1) = (-(20/(2*PhH))*(log10(peak2peak(BB)/HH))/TrF);
     alp(3,1) = (-(20/(2*PhH))*(log10(peak2peak(CC)/HH))/TrF);
     alp(4,1) = (-(20/(2*PhH))*(log10(peak2peak(EE)/HH))/TrF);
     alp(5,1) = (-(20/(2*PhH))*(log10(peak2peak(FF)/HH))/TrF);
     alp = sum(alp)/5;
     
     handles.Vp2U = GG;
     handles.alpU = alp;
     set(handles.Att,'String', round(alp,4));

    guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





% --- Executes on button press in W1.
function W1_Callback(hObject, eventdata, handles)

M1 = handles.M1;

if get(handles.W1,'Value')~=1
    M1(1,1)=0;
end
if get(handles.W2,'Value')~=1
    M1(2,1)=0;
end

if find(M1~=0) == 0
    errordlg('하나는 선택하자','Error'); 
end
A2=size(find(M1~=0));

ASD = (M1(1,1)+M1(2,1))/A2(1,1);

set(handles.AVp1,'String',ASD);
handles.ASD = ASD;
handles.Vp1U = ASD;
guidata(hObject,handles)




% --- Executes on button press in W2.
function W2_Callback(hObject, eventdata, handles)

M1 = handles.M1;

if get(handles.W1,'Value')~=1
    M1(1,1)=0;
end
if get(handles.W2,'Value')~=1
    M1(2,1)=0;
end

if find(M1~=0) == 0
    errordlg('하나는 선택하자','Error'); 
end
A2=size(find(M1~=0));

ASD = (M1(1,1)+M1(2,1))/A2(1,1);

set(handles.AVp1,'String',ASD);
handles.ASD = ASD;
handles.Vp1U = ASD;

guidata(hObject,handles)


% --- Executes on button press in P1.
function P1_Callback(hObject, eventdata, handles)

A1 = handles.ABCDE;

if get(handles.P1,'Value')~=1
    A1(1,1)=0;
end
if get(handles.P2,'Value')~=1
    A1(2,1)=0;
end
if get(handles.P3,'Value')~=1
    A1(3,1)=0;
end
if get(handles.P4,'Value')~=1
    A1(4,1)=0;
end
if get(handles.P5,'Value')~=1
    A1(5,1)=0;
end

    A2=size(find(A1~=0));

    ABCDE = (A1(1,1)+A1(2,1)+A1(3,1)+A1(4,1)+A1(5,1))/(A2(1,1));

    set(handles.AVp2,'String',round(ABCDE,6))
    HH = handles.ASD;
    TrF = str2double(get(handles.TrF,'String'));
    PhH = str2double(get(handles.PhH,'String'));


for C=1:5
    if A1(C,1)~=0
        alp(C,1) = -(20/(2*PhH))*(log10((A1(C,1)/HH))/TrF);
    else
        alp(C,1) = 0;
    end
end
    
    alp = sum(alp)/A2(1,1);

    set(handles.Att,'String',round(alp,4));
    handles.Vp2U = round(ABCDE,4);
    handles.alpU = alp;     
    
guidata(hObject,handles)



% --- Executes on button press in P2.
function P2_Callback(hObject, eventdata, handles)

A1 = handles.ABCDE;

if get(handles.P1,'Value')~=1
    A1(1,1)=0;
end
if get(handles.P2,'Value')~=1
    A1(2,1)=0;
end
if get(handles.P3,'Value')~=1
    A1(3,1)=0;
end
if get(handles.P4,'Value')~=1
    A1(4,1)=0;
end
if get(handles.P5,'Value')~=1
    A1(5,1)=0;
end

A2=size(find(A1~=0));
ABCDE = (A1(1,1)+A1(2,1)+A1(3,1)+A1(4,1)+A1(5,1))/(A2(1,1));

    set(handles.AVp2,'String',round(ABCDE,6))
    HH = handles.ASD;
    TrF = str2double(get(handles.TrF,'String'));
    PhH = str2double(get(handles.PhH,'String'));



for C=1:5
    if A1(C,1)~=0
        alp(C) = -(20/(2*PhH))*(log10((A1(C,1)/HH))/TrF);
    else
        alp(C,1) = 0;
    end
end

    alp = sum(alp)/A2(1,1);

    set(handles.Att,'String',round(alp,4));
    handles.Vp2U = round(ABCDE,4);
    handles.alpU = alp;
     
guidata(hObject,handles)


% --- Executes on button press in P3.
function P3_Callback(hObject, eventdata, handles)

A1 = handles.ABCDE;

if get(handles.P1,'Value')~=1
    A1(1,1)=0;
end
if get(handles.P2,'Value')~=1
    A1(2,1)=0;
end
if get(handles.P3,'Value')~=1
    A1(3,1)=0;
end
if get(handles.P4,'Value')~=1
    A1(4,1)=0;
end
if get(handles.P5,'Value')~=1
    A1(5,1)=0;
end

A2=size(find(A1~=0));
ABCDE = (A1(1,1)+A1(2,1)+A1(3,1)+A1(4,1)+A1(5,1))/(A2(1,1));

    set(handles.AVp2,'String',round(ABCDE,6))
    HH = handles.ASD;
    TrF = str2double(get(handles.TrF,'String'));
    PhH = str2double(get(handles.PhH,'String'));



for C=1:5
    if A1(C,1)~=0
        alp(C,1) = -(20/(2*PhH))*(log10((A1(C,1)/HH))/TrF);
    else
        alp(C,1) = 0;
    end
end
   
    alp = sum(alp)/A2(1,1);

    set(handles.Att,'String',round(alp,4));
    handles.Vp2U = round(ABCDE,4);
    handles.alpU = alp; 
     
guidata(hObject,handles)


% --- Executes on button press in P4.
function P4_Callback(hObject, eventdata, handles)

A1 = handles.ABCDE;

if get(handles.P1,'Value')~=1
    A1(1,1)=0;
end
if get(handles.P2,'Value')~=1
    A1(2,1)=0;
end
if get(handles.P3,'Value')~=1
    A1(3,1)=0;
end
if get(handles.P4,'Value')~=1
    A1(4,1)=0;
end
if get(handles.P5,'Value')~=1
    A1(5,1)=0;
end

A2=size(find(A1~=0));
ABCDE = (A1(1,1)+A1(2,1)+A1(3,1)+A1(4,1)+A1(5,1))/(A2(1,1));

    set(handles.AVp2,'String',round(ABCDE,4))
    HH = handles.ASD;
    TrF = str2double(get(handles.TrF,'String'));
    PhH = str2double(get(handles.PhH,'String'));


for C=1:5
    if A1(C,1)~=0
        alp(C,1) = -(20/(2*PhH))*(log10((A1(C,1)/HH))/TrF);
    else
        alp(C,1) = 0;
    end
end
   
    alp = sum(alp)/A2(1,1);

    set(handles.Att,'String',round(alp,4));
    handles.Vp2U = round(ABCDE,4);
    handles.alpU = alp; 
     
guidata(hObject,handles)


% --- Executes on button press in P5.
function P5_Callback(hObject, eventdata, handles)

A1 = handles.ABCDE;

if get(handles.P1,'Value')~=1
    A1(1,1)=0;
end
if get(handles.P2,'Value')~=1
    A1(2,1)=0;
end
if get(handles.P3,'Value')~=1
    A1(3,1)=0;
end
if get(handles.P4,'Value')~=1
    A1(4,1)=0;
end
if get(handles.P5,'Value')~=1
    A1(5,1)=0;
end

A2=size(find(A1~=0));
ABCDE = (A1(1,1)+A1(2,1)+A1(3,1)+A1(4,1)+A1(5,1))/(A2(1,1));

    set(handles.AVp2,'String',round(ABCDE,4));
    HH = handles.ASD;
    TrF = str2double(get(handles.TrF,'String'));
    PhH = str2double(get(handles.PhH,'String'));


for C=1:5
    if A1(C,1)~=0
        alp(C,1) = -(20/(2*PhH))*(log10((A1(C,1)/HH))/TrF);
    else
        alp(C,1) = 0;
    end
end
    
    alp = sum(alp)/A2(1,1);

    set(handles.Att,'String',round(alp,4));
    handles.Vp2U = round(ABCDE,4);
    handles.alpU = alp; 
    
    
guidata(hObject,handles)


% --- Executes on button press in D1.
function D1_Callback(hObject, eventdata, handles)
A1 = handles.DT;

if get(handles.D1,'Value')~=1
    A1(1,1)=0;
end
if get(handles.D2,'Value')~=1
    A1(2,1)=0;
end
if get(handles.D3,'Value')~=1
    A1(3,1)=0;
end
if get(handles.D4,'Value')~=1
    A1(4,1)=0;
end
if get(handles.D0,'Value')~=1
    A1(5,1)=0;
end

A2=size(find(A1~=0));
ABCDE = (A1(1,1)+A1(2,1)+A1(3,1)+A1(4,1)+A1(5,1))/(A2(1,1));

set(handles.AvrdT,'String',ABCDE);

handles.DTU = ABCDE;

guidata(hObject, handles)


% --- Executes on button press in D2.
function D2_Callback(hObject, eventdata, handles)
A1 = handles.DT;

if get(handles.D1,'Value')~=1
    A1(1,1)=0;
end
if get(handles.D2,'Value')~=1
    A1(2,1)=0;
end
if get(handles.D3,'Value')~=1
    A1(3,1)=0;
end
if get(handles.D4,'Value')~=1
    A1(4,1)=0;
end
if get(handles.D0,'Value')~=1
    A1(5,1)=0;
end

A2=size(find(A1~=0));
ABCDE = (A1(1,1)+A1(2,1)+A1(3,1)+A1(4,1)+A1(5,1))/(A2(1,1));

set(handles.AvrdT,'String',ABCDE);
handles.DTU = ABCDE;

guidata(hObject, handles)


% --- Executes on button press in D3.
function D3_Callback(hObject, eventdata, handles)
A1 = handles.DT;

if get(handles.D1,'Value')~=1
    A1(1,1)=0;
end
if get(handles.D2,'Value')~=1
    A1(2,1)=0;
end
if get(handles.D3,'Value')~=1
    A1(3,1)=0;
end
if get(handles.D4,'Value')~=1
    A1(4,1)=0;
end
if get(handles.D0,'Value')~=1
    A1(5,1)=0;
end

A2=size(find(A1~=0));
ABCDE = (A1(1,1)+A1(2,1)+A1(3,1)+A1(4,1)+A1(5,1))/(A2(1,1));

set(handles.AvrdT,'String',ABCDE);
handles.DTU = ABCDE;
guidata(hObject, handles)


% --- Executes on button press in D4.
function D4_Callback(hObject, eventdata, handles)
A1 = handles.DT;

if get(handles.D1,'Value')~=1
    A1(1,1)=0;
end
if get(handles.D2,'Value')~=1
    A1(2,1)=0;
end
if get(handles.D3,'Value')~=1
    A1(3,1)=0;
end
if get(handles.D4,'Value')~=1
    A1(4,1)=0;
end
if get(handles.D0,'Value')~=1
    A1(5,1)=0;
end

A2=size(find(A1~=0));
ABCDE = (A1(1,1)+A1(2,1)+A1(3,1)+A1(4,1)+A1(5,1))/(A2(1,1));

set(handles.AvrdT,'String',ABCDE);
handles.DTU = ABCDE;
guidata(hObject, handles)


% --- Executes on button press in D0.
function D0_Callback(hObject, eventdata, handles)
A1 = handles.DT;

if get(handles.D1,'Value')~=1
    A1(1,1)=0;
end
if get(handles.D2,'Value')~=1
    A1(2,1)=0;
end
if get(handles.D3,'Value')~=1
    A1(3,1)=0;
end
if get(handles.D4,'Value')~=1
    A1(4,1)=0;
end
if get(handles.D0,'Value')~=1
    A1(5,1)=0;
end

A2=size(find(A1~=0));
ABCDE = (A1(1,1)+A1(2,1)+A1(3,1)+A1(4,1)+A1(5,1))/(A2(1,1));

set(handles.AvrdT,'String',ABCDE);
handles.DTU = ABCDE;

guidata(hObject, handles)


% --- Executes on button press in Update.
function Update_Callback(hObject, eventdata, handles)
E = handles.FNTU;
A = handles.Vp1U;
B = handles.Vp2U;
C = handles.DTU;
D = handles.alpU;


d = get(handles.uitable1,'data');
d{2};

if d{1}==0
   Data = {E,A,B,C,D};
   set(handles.uitable1,'data',Data);
else
    d(end+1,:)={E,A,B,C,D};
   set(handles.uitable1,'data',d);
 end

guidata(hObject, handles)

% --- Executes on button press in Saveas.
function Saveas_Callback(hObject, eventdata, handles)
    SvF = get(handles.uitable1,'Data');
    FileName=uiputfile('*.xls','Save as');
    xlswrite(FileName,SvF);


% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
   oldDat = get(handles.uitable1,'Data');
   nRows = size(oldDat,1);
   dat = cell(nRows-1,3);
   dat = oldDat(1:nRows-1,:);
   set(handles.uitable1,'Data',dat);


% --- Executes on button press in TiniT.
function TiniT_Callback(hObject, eventdata, handles)
set(handles.uitable1,'data',{0 0 0 0 0});


% --- Executes on button press in IniT.
function IniT_Callback(hObject, eventdata, handles)
close all
run('ACQp.m')


% --- Executes on selection change in RowDATA.
function RowDATA_Callback(hObject, eventdata, handles)
% hObject    handle to RowDATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns RowDATA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RowDATA


% --- Executes during object creation, after setting all properties.
function RowDATA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RowDATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ColumnDATA.
function ColumnDATA_Callback(hObject, eventdata, handles)
% hObject    handle to ColumnDATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ColumnDATA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ColumnDATA


% --- Executes during object creation, after setting all properties.
function ColumnDATA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ColumnDATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PInitial.
function PInitial_Callback(hObject, eventdata, handles)
% hObject    handle to PInitial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Init(1,1)=get(handles.RowDATA,'Value');
handles.Init(1,2)=get(handles.ColumnDATA,'Value');
handles.Init(1,3)=get(handles.Ph_P,'Value');
handles.Init(1,4)=get(handles.Wa_P,'Value');
handles.Init(1,5)=str2double(get(handles.PhH,'String'));
handles.Init(1,6)=str2double(get(handles.TrF,'String'));
fID=fopen('InitialSetting.txt','w');
fprintf(fID,'%g %g %g %g %g %g %g',handles.Init');
fclose(fID);


guidata(hObject, handles);
