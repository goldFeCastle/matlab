function varargout = axis_mouse(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @axis_mouse_OpeningFcn, ...
                   'gui_OutputFcn',  @axis_mouse_OutputFcn, ...
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

function axis_mouse_OpeningFcn(hObject, eventdata, handles, varargin)
set(hObject,'WindowButtonDownFcn',{@my_MouseClickFcn,hObject});
set(hObject,'WindowButtonUpFcn',{@my_MouseReleaseFcn,hObject});
axes(handles.axes1);
set(handles.axes1,'xlim',[-10 10],'ylim',[-10 10]);
handles.output = hObject;
guidata(hObject,handles);

handles.output = hObject;
guidata(hObject, handles);

function varargout = axis_mouse_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function my_MouseClickFcn(hObject, eventdata, handles)
handles = guidata(hObject);
set(handles.figure1,'WindowButtonMotionFcn',{@my_MouseMoveFcn,hObject});
guidata(hObject,handles)

function my_MouseMoveFcn(hObject, eventdata, handles)
handles=guidata(hObject);
mousepos=get(handles.axes1,'CurrentPoint');
mousepos(1,2)
mousepos(1,1)

function my_MouseReleaseFcn(hObject, eventdata, handles)
handles = guidata(hObject);
set(handles.figure1,'WindowButtonMotionFcn','');
guidata(hObject,handles);

function insertImage_Callback(hObject, eventdata, handles)
img_dir = uigetdir('','Select the cell folder');
