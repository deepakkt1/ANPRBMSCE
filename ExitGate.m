function varargout = ExitGate(varargin)
% EXITGATE MATLAB code for ExitGate.fig
%      EXITGATE, by itself, creates a new EXITGATE or raises the existing
%      singleton*.
%
%      H = EXITGATE returns the handle to a new EXITGATE or the handle to
%      the existing singleton*.
%
%      EXITGATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXITGATE.M with the given input arguments.
%
%      EXITGATE('Property','Value',...) creates a new EXITGATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ExitGate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ExitGate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ExitGate

% Last Modified by GUIDE v2.5 23-Apr-2016 20:28:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ExitGate_OpeningFcn, ...
                   'gui_OutputFcn',  @ExitGate_OutputFcn, ...
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


% --- Executes just before ExitGate is made visible.
function ExitGate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ExitGate (see VARARGIN)

% Choose default command line output for ExitGate
handles.output = hObject;
imshow('initial.jpg','Parent',handles.axes4);
  imshow('logo.jpg','Parent',handles.axes3);
    set(handles.edit5, 'String', ' ');
  set(handles.edit6, 'String', ' ');

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
set(handles.edit8, 'String', num2str(bno));
set(handles.edit7, 'String', num2str(cno));


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ExitGate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ExitGate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
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



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
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
set(handles.edit8, 'String', num2str(bno));
set(handles.edit7, 'String', num2str(cno));




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[a b]= uigetfile('*.*','All Files');
handles.filename = [b a];
img=imread([b a]);
handles.Image=img;
guidata(hObject,handles)
  set(handles.edit5, 'String', ' ');
  set(handles.edit6, 'String', ' ');

imshow(img,'Parent',handles.axes4);
 imshow('logo.jpg','Parent',handles.axes3);



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
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
%Using ODBC driver.
conn = database('deepak', 'root', '');
t = datetime('now');

qry = 'update anprv set outt ="';
qry2 = ' "where vno ="';
sqlqry = [qry datestr(t) qry2 outpt '" order by entry DESC limit 1'];
curs = exec(conn, sqlqry);
curs = fetch(curs);
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
set(handles.edit8, 'String', num2str(bno));
set(handles.edit7, 'String', num2str(cno));

guidata(hObject);
 imshow('logo.jpg','Parent',handles.axes3);
 set(handles.edit6, 'String', num2str(output1));

set(handles.edit5, 'String', (outpt));



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
