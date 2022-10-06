
function varargout = lab1(varargin)
acc_arrays = zeros(100, 10000);
curr_acc_num = 0;
% LAB1 MATLAB code for lab1.fig
%      LAB1, by itself, creates a new LAB1 or raises the existing
%      singleton*.
%
%      H = LAB1 returns the handle to a new LAB1 or the handle to
%      the existing singleton*.
%
%      LAB1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB1.M with the given input arguments.
%
%      LAB1('Property','Value',...) creates a new LAB1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab1

% Last Modified by GUIDE v2.5 10-Sep-2022 06:56:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab1_OpeningFcn, ...
                   'gui_OutputFcn',  @lab1_OutputFcn, ...
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


% --- Executes just before lab1 is made visible.
function lab1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab1 (see VARARGIN)

% Choose default command line output for lab1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in aStart.
function aStart_Callback(hObject, eventdata, handles)
global curr_acc_num;
global acc_arrays;

acc_num = str2num(get(handles.num_of_acc, 'string'));
acc_flag = get(handles.acc_flag, 'Value');

sig_type = get(handles.sig_wave_type, 'Value');
points = str2num(get(handles.num_of_points, 'string'));
sigamp = str2double(get(handles.sig_amp, 'string'));
noise_type = get(handles.noise_type, 'Value');
sko = str2double(get(handles.sko, 'string'));
periods = str2num(get(handles.num_periods, 'string'));

noise = size(points);
switch noise_type
    case 1
        for i=1:points
            noise(i) = 0;
        end
    case 2
        noise = randn(points);
    case 3
        noise = wgn(points, 1, 0);
end

y = size(points);
for i=1:points %генерация модельного сигнала с шумом
    switch sig_type
        case 1            
            y(i) = sigamp * (sin((pi*i*periods)/points)) + noise(i) * sko;
        case 2
            y(i) = sigamp * (sawtooth((pi*i*periods)/points)) + noise(i) * sko;
        case 3
            y(i) = sigamp * (sawtooth((pi*i*periods)/points, 1/2)) + noise(i) * sko;
        case 4
            y(i) = sigamp * (square((pi*i*periods)/points)) + noise(i) * sko;
    end
end

if acc_flag == 0
    x=1:points;
    plot(x,y);
else
    if curr_acc_num > acc_num
        curr_acc_num = 1;
        acc_arrays(:, :) = 0;
    end 

    
    for i=1:points
        acc_arrays(curr_acc_num, i) = y(i);
    end
    
    x = 1:points;
    y = sum(acc_arrays) / curr_acc_num;
    plot(x,y(1:points));
    
    set(handles.acc_edit, 'String', curr_acc_num);
    curr_acc_num = curr_acc_num + 1;
end
% hObject    handle to aStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in aQuit.
function aQuit_Callback(hObject, eventdata, handles)
fclose('all');
close ('all');

% hObject    handle to aQuit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function periods_number_Callback(hObject, eventdata, handles)
% hObject    handle to periods_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of periods_number as text
%        str2double(get(hObject,'String')) returns contents of periods_number as a double


% --- Executes during object creation, after setting all properties.
function periods_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to periods_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sig_type_txt.
function sig_type_Callback(hObject, eventdata, handles)
% hObject    handle to sig_type_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sig_type_txt contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sig_type_txt


% --- Executes during object creation, after setting all properties.
function sig_type_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_type_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function num_of_points_Callback(hObject, eventdata, handles)
% hObject    handle to num_of_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_of_points as text
%        str2double(get(hObject,'String')) returns contents of num_of_points as a double


% --- Executes during object creation, after setting all properties.
function num_of_points_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_of_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sig_amp_Callback(hObject, eventdata, handles)
% hObject    handle to sig_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sig_amp as text
%        str2double(get(hObject,'String')) returns contents of sig_amp as a double


% --- Executes during object creation, after setting all properties.
function sig_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sko_Callback(hObject, eventdata, handles)
% hObject    handle to sko (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sko as text
%        str2double(get(hObject,'String')) returns contents of sko as a double


% --- Executes during object creation, after setting all properties.
function sko_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sko (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_periods_Callback(hObject, eventdata, handles)
% hObject    handle to num_periods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_periods as text
%        str2double(get(hObject,'String')) returns contents of num_periods as a double


% --- Executes during object creation, after setting all properties.
function num_periods_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_periods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in noise_type.
function noise_type_Callback(hObject, eventdata, handles)
% hObject    handle to noise_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns noise_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from noise_type


% --- Executes during object creation, after setting all properties.
function noise_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over sig_type.
function sig_type_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to sig_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in sig_wave_type.
function sig_wave_type_Callback(hObject, eventdata, handles)
% hObject    handle to sig_wave_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sig_wave_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sig_wave_type


% --- Executes during object creation, after setting all properties.
function sig_wave_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_wave_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in acc_flag.
function acc_flag_Callback(hObject, eventdata, handles)
% hObject    handle to acc_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of acc_flag



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



function num_of_acc_Callback(hObject, eventdata, handles)
% hObject    handle to num_of_acc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_of_acc as text
%        str2double(get(hObject,'String')) returns contents of num_of_acc as a double


% --- Executes during object creation, after setting all properties.
function num_of_acc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_of_acc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function acc_edit_Callback(hObject, eventdata, handles)
% hObject    handle to acc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of acc_edit as text
%        str2double(get(hObject,'String')) returns contents of acc_edit as a double


% --- Executes during object creation, after setting all properties.
function acc_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to acc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
