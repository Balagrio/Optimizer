function [erg] = optimizor(fitnessFunc, useMOO, nTest, nVar, stellen, A0_min, W0_min, W0_max, L0_min, L0_max, R1_min, R2_min, R_max)
tic
% Allocation
erg = zeros(nTest + 1, nVar + 1); 
% Ausgangsminimum in erste Zeile
erg(1, 1:nVar + 1) = [A0_min,W0_min,L0_min,R1_min,R2_min,-fitnessFunc([A0_min,W0_min,L0_min,R1_min,R2_min])];

% Minimal- und Maximalwerte
if R_max < W0_min/2
    minLim = [A0_min,                       W0_min, 		L0_min, 	R1_min, 	R2_min];
    maxLim = [atand((2*L0_max)/W0_min),     W0_max, 		L0_max, 	R_max,      R_max];
else
    minLim = [A0_min,                       W0_min, 		L0_min, 	R1_min, 	R2_min];
    maxLim = [atand((2*L0_max)/W0_min),     W0_max, 		L0_max, 	W0_min/2,   W0_min/2];
end

% Zaehler
r = 1;

%% Optimierung
if useMOO == 'y'
    for i = 2:nTest + 1
        % Status
        pos = [num2str(r), '/', num2str(nTest)];
        disp(pos);
        % Optimierung eines Individuums
        res = runden(gamultiobj(fitnessFunc,nVar,[],[],[],[],minLim,maxLim),stellen);
        erg(i, 1:nVar) = res(1:nVar); % Werte
        erg(i, nVar + 1) = -fitnessFunc(erg(i, 1:nVar)); % f in letzter Spalte
        % Zaehler
        r = r + 1;
    end
else    
    for i = 2:nTest + 1
        % Status
        pos = [num2str(r), '/', num2str(nTest)];
        disp(pos);
        % Optimierung eines Individuums
        res = runden(ga(fitnessFunc,nVar,[],[],[],[],minLim,maxLim),stellen);
        erg(i, 1:nVar) = res(1:nVar); % Werte
        erg(i, nVar + 1) = -fitnessFunc(erg(i, 1:nVar)); % f in letzter Spalte
        % Zaehler
        r = r + 1;
    end
end
end
