function varargout = EntryApp(varargin)
% ENTRYAPP MATLAB code for EntryApp.fig
%      ENTRYAPP, by itself, creates a new ENTRYAPP or raises the existing
%      singleton*.
%
%      H = ENTRYAPP returns the handle to a new ENTRYAPP or the handle to
%      the existing singleton*.
%
%      ENTRYAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENTRYAPP.M with the given input arguments.
%
%      ENTRYAPP('Property','Value',...) creates a new ENTRYAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EntryApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EntryApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EntryApp

% Last Modified by GUIDE v2.5 11-Apr-2016 15:31:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EntryApp_OpeningFcn, ...
                   'gui_OutputFcn',  @EntryApp_OutputFcn, ...
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


% --- Executes just before EntryApp is made visible.
function EntryApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EntryApp (see VARARGIN)

% Choose default command line output for EntryApp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EntryApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);
handles.vid = videoinput('winvideo',1);
hImage = image(zeros(640, 480, 3), 'Parent', handles.axes2);

% For Webcam, uncomment the next 2 lines and comment the third line
% handles.cam = webcam('see me here');
% preview(handles.cam, hImage);
preview(handles.vid, hImage);

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = EntryApp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

img = getsnapshot(handles.vid);
% img = snapshot(handles.cam); % For webcam only
% [a b] = uigetfile('*.*','All Files');
% img = imread([b a]);
handles.Image = img;
guidata(hObject, handles);
imshow(img, 'Parent', handles.axes1);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);
img1 = handles.Image;
keySet = {1, 2};
valueSet = {'Bike','Car'};
mapObj = containers.Map(keySet, valueSet);
load('TrainedValues.mat'); % load trained theta values for classification
X_test=Image2Matrix(img1);
pred = predict(Theta1, Theta2, X_test(1,:));
vehicleType = mapObj(pred);
set(handles.edit1, 'String', num2str(vehicleType));
img2 = handles.Image;
I = getImageHere(img2);
imshow(I,'Parent',handles.axes1);
RecognizeNP(I);
NumberPlate = mainone(I);
imshow(img2, 'Parent', handles.axes1);
set(handles.edit2, 'String', (NumberPlate));
guidata(hObject, handles);
% clear;

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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
