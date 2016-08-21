function varargout = EntryGate(varargin)
% ENTRYGATE MATLAB code for EntryGate.fig
%      ENTRYGATE, by itself, creates a new ENTRYGATE or raises the existing
%      singleton*.
%
%      H = ENTRYGATE returns the handle to a new ENTRYGATE or the handle to
%      the existing singleton*.
%
%      ENTRYGATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENTRYGATE.M with the given input arguments.
%
%      ENTRYGATE('Property','Value',...) creates a new ENTRYGATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EntryGate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EntryGate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EntryGate

% Last Modified by GUIDE v2.5 23-Apr-2016 20:19:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EntryGate_OpeningFcn, ...
                   'gui_OutputFcn',  @EntryGate_OutputFcn, ...
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


% --- Executes just before EntryGate is made visible.
function EntryGate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EntryGate (see VARARGIN)

% Choose default command line output for EntryGate
handles.output = hObject;
imshow('initial.jpg','Parent',handles.axes2);
  imshow('logo.jpg','Parent',handles.axes1);
  set(handles.edit1, 'String', ' ');
  set(handles.edit2, 'String', ' ');

  setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');

%Make connection to database.  Note that the password has been omitted.
%Using ODBC driver.
conn = database('deepak', 'root', '');
car = exec(conn,'select typ from anprv where typ = "car" and outt IS null');
car = fetch(car)
[cno du] = size(car.Data)
bike = exec(conn,'select typ from anprv where typ = "bike" and outt IS null');
bike = fetch(bike)
[bno du] = size(bike.Data);
if(strcmp(car.Data,'No Data'))
    cno = 0;
end
if(strcmp(bike.Data,'No Data'))
    bno = 0;
end

vehicle = exec(conn,'select * from anprv');
vehicle = fetch(vehicle);
formatSpec = '%10s %20s %21s %4s %s\r\n';

% T = cell2table(vehicle.Data,'VariableNames',{'Vehicle no','Entry time','Exit time','Vehicle type','Image path'});
% writetable(T,'tabledata.dat')
fileID = fopen('vehicleDB.txt','w');
[nrows,ncols] = size(vehicle.Data);
 fprintf(fileID,'%10s %20s %21s %4s %s\r\n','Vehicle no','Entry Date and Time','Exit Date and Time','Type','Image path');
for row = 1:nrows
    fprintf(fileID,formatSpec,vehicle.Data{row,:});
end
fclose(fileID);
close(conn);
set(handles.edit4, 'String', num2str(bno));
set(handles.edit3, 'String', num2str(cno));


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EntryGate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EntryGate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');

%Make connection to database.  Note that the password has been omitted.
%Using ODBC driver.
conn = database('deepak', 'root', '');

vehicle = exec(conn,'select * from anprv');
vehicle = fetch(vehicle);
formatSpec = '%10s %20s %21s %4s %s\r\n';

fileID = fopen('vehicleDB.txt','w');
[nrows,ncols] = size(vehicle.Data);
 fprintf(fileID,'%10s %20s %21s %4s %s\r\n','Vehicle no','Entry Date and Time','Exit Date and Time','Type','Image path');
for row = 1:nrows
    fprintf(fileID,formatSpec,vehicle.Data{row,:});
end
fclose(fileID);
close(conn);

system(['notepad ' pwd '\vehicleDB.txt']);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');
conn = database('deepak', 'root', '');
clea = exec(conn,'truncate anprv');
clea = fetch(clea);
car = exec(conn,'select typ from anprv where typ = "car" and outt IS null');
car = fetch(car)
[cno du] = size(car.Data)
bike = exec(conn,'select typ from anprv where typ = "bike" and outt IS null');
bike = fetch(bike)
[bno du] = size(bike.Data)
if(strcmp(car.Data,'No Data'))
    cno = 0;
end
if(strcmp(bike.Data,'No Data'))
    bno = 0;
end

close(conn);
set(handles.edit4, 'String', num2str(bno));
set(handles.edit3, 'String', num2str(cno));


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[a b]= uigetfile('*.*','All Files');
handles.filename = [b a];
img=imread([b a]);
handles.Image=img;
guidata(hObject,handles)
imshow(img,'Parent',handles.axes2);
 imshow('logo.jpg','Parent',handles.axes1);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles)
img=handles.Image;
img=handles.Image;
I = getImageHere(img);
outpt = Segmentation();


keySet = {1, 2};
valueSet = {'Bike','Car'};
mapObj = containers.Map(keySet, valueSet);
load('TrainedValues.mat'); % load trained theta values for classification

X_test=Image2Matrix(img);
pred = predict(Theta1, Theta2, X_test(1,:));
output1=mapObj(pred);
typ = output1;
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');
d = handles.filename;
%d = reshape(img, 1, []);
%Make connection to database.  Note that the password has been omitted.
%Using ODBC driver.
conn = database('deepak', 'root', '');
colnams= {'vno' 'entry' 'outt' 'typ' 'image'};
 vales={outpt  datestr(datetime('now')) '' typ d};
 datainsert(conn,'ANPRV',colnams,vales) ;
car = exec(conn,'select typ from anprv where typ = "car" and outt IS null');
car = fetch(car)
[cno du] = size(car.Data)
bike = exec(conn,'select typ from anprv where typ = "bike" and outt IS null');
bike = fetch(bike)
[bno du] = size(bike.Data)
if(strcmp(car.Data,'No Data'))
    cno = 0;
end
if(strcmp(bike.Data,'No Data'))
    bno = 0;
end

close(conn);
set(handles.edit4, 'String', num2str(bno));
set(handles.edit3, 'String', num2str(cno));

guidata(hObject);
 imshow('logo.jpg','Parent',handles.axes1);
 set(handles.edit2, 'String', num2str(output1));

set(handles.edit1, 'String', (outpt));



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
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
