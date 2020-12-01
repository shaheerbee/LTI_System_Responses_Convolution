%%
% III: cumulative sum
n = 0:15;
x = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; % unit impulse
v = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; % unit step 

ASR = ltisystemA(n,v); % A step response
BSR = ltisystemB(n,v); % B step response
CSR = ltisystemC(n,v); % C step response

AIR = ltisystemA(n,x); % A impulse response
BIR = ltisystemB(n,x); % A impulse response
CIR = ltisystemC(n,x); % A impulse response

AC = cumsum(AIR); % sum IR
BC = cumsum(BIR);
CC = cumsum(CIR);

A = true;
B = true;
C = true;

for i = 1:15
    if round(ASR(i),2) ~= round(AC(i),2)
        A = false;
        break
    end
end
for i = 1:15
    if round(BSR(i), 2) ~= round(BC(i),2)
        B = false;
        break
    end
end
for i = 1:15
    if round(CSR(i), 2) ~= round(CC(i),2)
        C = false;
        break
    end
end

disp('III')
disp('A:')
A
disp('B:')
B
disp('C:')
C

% IV: first difference

AFD = diff(ASR, 1); % first difference
AFD(end+1:numel(n))=0; % resize the vector account for lost index

BFD = diff(BSR, 1);
BFD(end+1:numel(n))=0;

CFD = diff(CSR, 1);
CFD(end+1:numel(n))=0;

A = true;
B = true;
C = true;

for i = 1:14
    if (round(AFD(i),2) ~= round(AIR(i+1),2))
        A = false;
        break
    end
end

for i = 1:14
    if (round(BFD(i),2) ~= round(BIR(i+1),2))
        B = false;
        break
    end
end

for i = 1:14
    if (round(CFD(i),2) ~= round(CIR(i+1),2))
        C = false;
        break
    end
end
disp('IV')
disp('A:')
A
disp('B:')
B
disp('C:')
C

% V: convolution

load ECG_assignment2.mat
ecg = x;
necg = [1:length(ecg)];
y_ecgSA = ltisystemA(necg, ecg); 
y_ecgSB = ltisystemB(necg, ecg); 
y_ecgSC = ltisystemC(necg, ecg); 

load respiration_assignment2.mat,resp = x;  %followed the same import procedure as above
nresp = [1:length(resp)]; 
y_respA = ltisystemA(nresp, resp); %computed the output of the ltisystem  
y_respB = ltisystemB(nresp, resp);
y_respC = ltisystemC(nresp, resp);


n = -5:15; 
x = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
yA = ltisystemA(n,x);
yB = ltisystemB(n,x);
yC = ltisystemC(n,x);

%convolutions of ECG 
conv_ecgA = conv(ecg, yA);
conv_ecgA = conv_ecgA([6:length(conv_ecgA)-15]);

conv_ecgB = conv(ecg, yB);
conv_ecgB = conv_ecgB([6:length(conv_ecgB)-15]);

conv_ecgC = conv(ecg, yC);
conv_ecgC = conv_ecgC([6:length(conv_ecgC)-15]);

%Convolutions of RESP 
conv_respA = conv(resp, yA);
conv_respA = conv_respA([6:length(conv_respA)-15]);

conv_respB = conv(resp, yB);
conv_respB = conv_respB([6:length(conv_respB)-15]);

conv_respC = conv(resp, yC);
conv_respC = conv_respC([6:length(conv_respC)-15]);

A = true;
B = true;
C = true;

A2 = true;
B2 = true; 
C2 = true; 

%ECG Tests 

for i = 1:15
    if (round(conv_ecgA(i),1) ~= round(y_ecgSA(i),1))
        A = false;
        break
    end
end

for i = 1:15
    if (round(conv_ecgB(i),1) ~= round(y_ecgSB(i),1))
        B = false;
        break
    end
end

for i = 1:15
    if (round(conv_ecgC(i),2) ~= round(y_ecgSC(i),2))
        C = false;
        break
    end
end

%RESP Tests 

for i = 1:15
    if (round(conv_respA(i),1) ~= round(y_respA(i),1))
        A2 = false;
        break
    end
end

for i = 1:15
    if (round(conv_respB(i),1) ~= round(y_respB(i),1))
        B2 = false;
        break
    end
end

for i = 1:15
    if (round(conv_respC(i),1) ~= round(y_respC(i),1))
        C2 = false;
        break
    end
end


disp('VII (for ECG)')
disp('A:')
A
disp('B:')
B
disp('C:')
C

disp('VII (for RESP)')
disp('A:')
A2
disp('B:')
B2
disp('C:')
C2