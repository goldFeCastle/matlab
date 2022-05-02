function varargout = mouse_position(varargin)
% MOUSE_POSITION MATLAB code for mouse_position.fig
%      MOUSE_POSITION, by itself, creates a new MOUSE_POSITION or raises the existing
%      singleton*.
%
%      H = MOUSE_POSITION returns the handle to a new MOUSE_POSITION or the handle to
%      the existing singleton*.
%
%      MOUSE_POSITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOUSE_POSITION.M with the given input arguments.
%
%      MOUSE_POSITION('Property','Value',...) creates a new MOUSE_POSITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mouse_position_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mouse_position_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mouse_position

% Last Modified by GUIDE v2.5 11-May-2017 01:04:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mouse_position_OpeningFcn, ...
                   'gui_OutputFcn',  @mouse_position_OutputFcn, ...
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


% --- Executes just before mouse_position is made visible.
function mouse_position_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mouse_position (see VARARGIN)

% Choose default command line output for mouse_position
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mouse_position wait for user response (see UIRESUME)
% uiwait(handles.mouse_position);


% --- Outputs from this function are returned to the command line.
function varargout = mouse_position_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse motion over figure - except title and menu.
function mouse_position_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to mouse_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pos = get(hObject,'currentpoint');
x = pos(1);y=pos(2);
set(handles.lbl_x,'string',['X pos:' num2str(x)]);
set(handles.lbl_y,'string',['Y pos:' num2str(x)]);
