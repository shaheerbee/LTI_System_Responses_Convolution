%%
% Impulse Response Analysis
n = 0:1000;
x = zeros(1, 1001); % unit impulse
x(1) = 1;

y1 = ltisystemA(n, x);
y2 = ltisystemB(n, x);
y3 = ltisystemC(n, x);

nzoA = 0;
nzoB = 0;
nzoC = 0;

% storing the index of the last non-zero output in 1000 timesteps 
% (an arbitrarily large range)
for i = 1:1000
    if (y1(i) ~= 0)
        nzoA = i;
    end
    if (y2(i) ~= 0)
        nzoB = i;
    end
    if (y3(i) ~= 0)
        nzoC = i;
    end
end

disp('last nzo A: ')
disp(nzoA)
disp('last nzo B: ')
disp(nzoB)
disp('last nzo C: ')
disp(nzoC)

