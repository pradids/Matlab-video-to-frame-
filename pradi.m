function varargout = pradi(varargin)
% PRADI MATLAB code for pradi.fig
%      PRADI, by itself, creates a new PRADI or raises the existing
%      singleton*.
%
%      H = PRADI returns the handle to a new PRADI or the handle to
%      the existing singleton*.
%
%      PRADI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRADI.M with the given input arguments.
%
%      PRADI('Property','Value',...) creates a new PRADI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pradi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pradi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pradi

% Last Modified by GUIDE v2.5 13-Oct-2015 14:50:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pradi_OpeningFcn, ...
                   'gui_OutputFcn',  @pradi_OutputFcn, ...
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


% --- Executes just before pradi is made visible.
function pradi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pradi (see VARARGIN)

% Choose default command line output for pradi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pradi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pradi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fn,pn]=uigetfile('*.*;*.avi;*.mp4');
a=[pn,fn];
handles.a=a;
set(handles.activex1,'url',a);
guidata(hObject,handles);


% --- Executes on button press in frame.
function frame_Callback(hObject, eventdata, handles)
% hObject    handle to frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c=handles.a;
mkdir('D:\pds\img');
shuttleVideo = VideoReader(c);
for ii = 1:shuttleVideo.NumberOfFrames
    img = read(shuttleVideo,ii);
axes(handles.axes1);
imshow(img);

%pause(0.3);
    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
    imwrite(img,fullfile('D:\pds\2',sprintf('img%d.jpg',ii)));
end


% --- Executes on button press in vid.
function vid_Callback(hObject, eventdata, handles)
% hObject    handle to vid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImFolder=uigetdir;
jpgFile = dir(strcat(ImFolder,'\*.jpg'));
S = [jpgFile(:).datenum]; 
[S,S] = sort(S);
jpgFiles = jpgFile(S);
VideoFile=strcat(ImFolder,'\compressed Video');
writeObj = VideoWriter(VideoFile);
fps= 10; 
writeObj.FrameRate = fps;
open(writeObj);
for t= 1:length(jpgFiles)
     Frame=imread(strcat(ImFolder,'\',jpgFiles(t).name));
     writeVideo(writeObj,im2frame(Frame));
    
end
as='D:\PRADEEP\2\compressed Video.avi';
set(handles.activex1,'url',as);
%guidata(hObject,handles);

close(writeObj);