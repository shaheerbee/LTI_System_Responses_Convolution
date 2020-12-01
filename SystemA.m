%%
%Question 1
n_index = 0:15;
x = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; % unit impulse 
y_ImpulseResponse = ltisystemA(n_index,x); 

figure(1), 
subplot(1,1,1), stem(n_index, y_ImpulseResponse), title("System A Impulse Response"), xlabel("n"), ylabel("y[n]");
%%
%Question 2 & 3
n_index = 0:15;
x = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
v = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; % unit step 

SystemA_U = ltisystemA(n_index,v); % step response
y2_ImpulseResponse = ltisystemA(n_index,x); % impulse response 
A = cumsum(y2_ImpulseResponse); % sum IR

figure(2), 
subplot(1,1,1), stem(n_index, SystemA_U), title("System A Unit Step Response"), xlabel("n"), ylabel("y[n]"); 

figure(3), 
subplot(2,1,1), stem(n_index, SystemA_U), title("System A Unit Step Response"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), stem(n_index, SystemA_U), title("Cumulative Sum of the Impulse Response"), xlabel("n"), ylabel("y[n]"); 

%%
%Question 4
n_index = 0:15;
x = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
v = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

SystemA_U = ltisystemA(n_index,v); % step response 
FD = diff(SystemA_U, 1); % first difference
FD(end+1:numel(n_index))=0; % resize the vector account for lost index

y2_ImpulseResponse = ltisystemA(n_index,x); 

figure(4), 
subplot(2,1,1), stem(n_index, FD), title("First Difference of the Unit Step Response"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), stem(n_index, y2_ImpulseResponse), title("Unit Impulse Function Output"), xlabel("n"), ylabel("y[n]"); 
%%

%Question 5 & 6
load ECG_assignment2.mat
ecg = x;
nindex1_ecg = [1:length(ecg)]; 
y_ecgSystemOutputA = ltisystemA(nindex1_ecg, ecg); 

n = -5:15; 
x = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

load respiration_assignment2.mat
resp = x;
nindex1_resp = [1:length(resp)]; 
y_respSystemOutputA = ltisystemA(nindex1_resp, resp); 

n = -5:15; 
x = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

figure(5),
subplot(2,1,1), plot(nindex1_ecg, y_ecgSystemOutputA), title("ECG Output Signal for System A | y[n]"), xlabel("n"), ylabel("y[n]");
subplot(2,1,2), plot(nindex1_resp, y_respSystemOutputA), title("Respiratory Output Signal for System A | y[n]"), xlabel("n"), ylabel("y[n]");
%%
%Question 7 
load ECG_assignment2.mat
ecg = x;
nindex_ecg = [1:length(ecg)];
y_ecgSA = ltisystemA(nindex_ecg, ecg); 
l1 = length(y_ecgSA);
disp(l1);

load respiration_assignment2.mat
resp = x; 
nindex_resp = [1:length(resp)];
y_respSA = ltisystemA(nindex_resp, resp); 

n = -5:15; 
x = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
yA = ltisystemA(n,x); 

conv_ecgA = conv(ecg, yA);
conv_ecgA = conv_ecgA([6:length(conv_ecgA)-15]); 
l2 = length(conv_ecgA); 
disp(l2);

figure(6),
subplot(2,1,1), plot(nindex_ecg, y_ecgSA), title("ECG Output Signal for System A | y[n]"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), plot(nindex_ecg, conv_ecgA), title("Convolved Signal for System A | y[n]"), xlabel("n"), ylabel("y[n]"); 

conv_respA = conv(resp, yA); 
conv_respA = conv_respA([6:length(conv_respA)-15]); 

figure (7),
subplot(2,1,1), plot(nindex_resp, y_respSA), title("Respiratory Output Signal for System A | y[n]"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), plot(nindex_resp, conv_respA), title("Convolved Signal for System A | y[n]"), xlabel("n"), ylabel("y[n]"); 
%%
