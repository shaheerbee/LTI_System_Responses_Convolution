%%
%Question 1
n_index = 0:15;
x = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; % unit impulse 
y_ImpulseResponse = ltisystemC(n_index,x); 

figure(1), 
subplot(1,1,1), stem(n_index, y_ImpulseResponse), title("System C Impulse Response"), xlabel("n"), ylabel("y[n]");
%%
%Question 2 & 3
n_index = 0:15;
x = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
v = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; % unit step 

SystemC_U = ltisystemC(n_index,v); % get unit step response
A = cumsum(y_ImpulseResponse);

figure(2), 
subplot(1,1,1), stem(n_index, SystemC_U), title("System C Unit Step Response"), xlabel("n"), ylabel("y[n]"); %plot the Unit Step Output

figure(3), 
subplot(2,1,1), stem(n_index, SystemC_U), title("System C Unit Step Response"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), stem(n_index, A), title("Cumulative Sum of the Impulse Response"), xlabel("n"), ylabel("y[n]"); 

%%
%Question 4
n_index = 0:15;
x = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
v = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; % unit step

y2_ImpulseResponse = ltisystemC(n_index,x); 

SystemC_U = ltisystemC(n_index,v); %COMPUTE THE output of the unit step response 
FD = diff(SystemC_U, 1); %1st difference of the unit imput output of System B
FD(end+1:numel(n_index))=0; %resize the vector to the index array

figure(4), 
subplot(2,1,1), stem(n_index, FD), title("First Difference of the Unit Step Response"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), stem(n_index, y2_ImpulseResponse), title("Unit Impulse Function Output"), xlabel("n"), ylabel("y[n]"); 
%%

%Question 5 & 6
load ECG_assignment2.mat
ecg = x;
nindex1_ecg = [1:length(ecg)]; 
y_ecgSystemOutputC = ltisystemC(nindex1_ecg, ecg); 

n = -5:15; 
x = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

load respiration_assignment2.mat
resp = x;
nindex1_resp = [1:length(resp)]; 
y_respSystemOutputC = ltisystemC(nindex1_resp, resp); 

n = -5:15; 
x = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

figure(5),
subplot(2,1,1), plot(nindex_ecg, y_ecgSystemOutputC), title("ECG Output Signal for System C | y[n]"), xlabel("n"), ylabel("y[n]");
subplot(2,1,2), plot(nindex_resp, y_respSystemOutputC), title("Respiratory Output Signal for System C | y[n]"), xlabel("n"), ylabel("y[n]");
%%
%Question 7 
load ECG_assignment2.mat
ecg = x;
nindex_ecg = [1:length(ecg)];
y_ecgSC = ltisystemC(nindex_ecg, ecg); 
l1 = length(y_ecgSC);
disp(l1);

load respiration_assignment2.mat
resp = x; 
nindex_resp = [1:length(resp)];
y_respC = ltisystemC(nindex_resp, resp); 

n = -5:15; 
x = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
yC = ltisystemC(n,x); 

conv_ecgC = conv(ecg, yC);
conv_ecgC = conv_ecgC([6:length(conv_ecgC)-15]); 
l2 = length(conv_ecgC); 
disp(l2);

figure(6),
subplot(2,1,1), plot(nindex_ecg, y_ecgSC), title("ECG Output Signal for System C | y[n]"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), plot(nindex_ecg, conv_ecgC), title("Convolved Signal for System C | y[n]"), xlabel("n"), ylabel("y[n]"); 

conv_respA = conv(resp, yC); 
conv_respA = conv_respA([6:length(conv_respA)-15]); 

figure (7),
subplot(2,1,1), plot(nindex_resp, y_respC), title("Respiratory Output Signal for System C | y[n]"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), plot(nindex_resp, conv_respA), title("Convolved Signal for System C | y[n]"), xlabel("n"), ylabel("y[n]"); 
%%
