%%
%Question 1
n_index = 0:15;
x = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; % unit impulse 
y_ImpulseResponse = ltisystemB(n_index,x); 

figure(1), 
subplot(1,1,1), stem(n_index, y_ImpulseResponse), title("System B Impulse Response"), xlabel("n"), ylabel("y[n]");
%%
%Question 2 & 3
n_index = 0:15;
x = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
v = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; % unit step 

SystemB_U = ltisystemB(n_index,v); % step response
A = cumsum(y_ImpulseResponse);

figure(2), 
subplot(1,1,1), stem(n_index, SystemB_U), title("System B Unit Step Response"), xlabel("n"), ylabel("y[n]"); 

figure(3), 
subplot(2,1,1), stem(n_index, SystemB_U), title("System B Unit Step Response"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), stem(n_index, A), title("Cumulative Sum of the Impulse Response"), xlabel("n"), ylabel("y[n]"); 

%%
%Question 4
n_index = 0:15;
x = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
v = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; % unit step

y2_ImpulseResponse = ltisystemB(n_index,x); 

SystemB_U = ltisystemB(n_index,v); %COMPUTE THE output of the unit step response 
FD = diff(SystemB_U, 1); % 1st difference of the unit imput output of System B
FD(end+1:numel(n_index))=0; % resize the vector to the index array

figure(4), 
subplot(2,1,1), stem(n_index, FD), title("First Difference of the Unit Step Response"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), stem(n_index, y2_ImpulseResponse), title("Unit Impulse Function Output"), xlabel("n"), ylabel("y[n]"); 
%%

%Question 5 & 6
load ECG_assignment2.mat % load 
ecg = x; % import x variables as ecg 
nindex1_ecg = [1:length(ecg)]; %set index 
y_ecgSystemOutputB = ltisystemB(nindex1_ecg, ecg); 

load respiration_assignment2.mat
resp = x;
nindex1_resp = [1:length(resp)]; 
y_respSystemOutputB = ltisystemB(nindex1_resp, resp); 

figure(5),
subplot(2,1,1), plot(nindex1_ecg, y_ecgSystemOutputB), title("ECG Output Signal for System A | y[n]"), xlabel("n"), ylabel("y[n]");
subplot(2,1,2), plot(nindex1_resp, y_respSystemOutputB), title("Respiratory Output Signal for System A | y[n]"), xlabel("n"), ylabel("y[n]");
%%
%Question 7 
load ECG_assignment2.mat
ecg = x;
nindex_ecg = [1:length(ecg)];
y_ecgSB = ltisystemB(nindex_ecg, ecg); 
l1 = length(y_ecgSB);
disp(l1);

load respiration_assignment2.mat
resp = x; 
nindex_resp = [1:length(resp)];
y_respBA = ltisystemB(nindex_resp, resp); 

n = -5:15; 
x = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
yA = ltisystemB(n,x); 

conv_ecgB = conv(ecg, yA);
conv_ecgB = conv_ecgB([6:length(conv_ecgB)-15]); 
l2 = length(conv_ecgB); 
disp(l2);

figure(6),
subplot(2,1,1), plot(nindex_ecg, y_ecgSB), title("ECG Output Signal for System B | y[n]"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), plot(nindex_ecg, conv_ecgB), title("Convolved Signal for System B | y[n]"), xlabel("n"), ylabel("y[n]"); 

conv_respA = conv(resp, yA); 
conv_respA = conv_respA([6:length(conv_respA)-15]); 

figure (7),
subplot(2,1,1), plot(nindex_resp, y_respBA), title("Respiratory Output Signal for System B | y[n]"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), plot(nindex_resp, conv_respA), title("Convolved Signal for System B | y[n]"), xlabel("n"), ylabel("y[n]"); 
%%
