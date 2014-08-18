%% Automatisierter Optimierer
% Christopher Sauer, 2014

%% RapidMiner
rapidminered = input('RM Modell generiert? (j/n): ','s');
if strcmp(rapidminered, 'n')
    pathToRapidminer = input('Wo befindet sich RapidMiner? ','s');
    pathTioProcess = input('Wo befindet sich der Prozess? ', 's');
    processName = input('Wie heisst der Prozess? ', 's');
    runrapidminer(pathToRapidminer, pathToProcess, processName);
    disp('-----------------');
end

%% Parsor
parsed = input('RM Modell geparst? (j/n): ','s');
if strcmp(parsed, 'n')
    method = input('Parsor Methode waehlen: ','s');
    filename = input('Dateiname angeben: ','s');
    predictionLabel = input('Vorhersagegroesse angeben: ','s');
    firstChar = input('Erster Variablenbuchstabe: ','s');
    functionName = input('Name der zu generierenden Matlabfunktion: ','s');
    runparsor('parsor.exe',method,filename,predictionLabel,firstChar, ...
        functionName);
    disp('-----------------');
end

%% Optimierung
% Standard
nTest = 10; nVar = 5; stellen = 2; 
% Benutzerabfragen
%fitnessFunc = @fitness; % wenn mcc Export (Restriktion!)
fitnessFunc = input('Fitnessfunktion: ');
sign = input('Vorzeichenumkehr? (j/n): ','s');
if strcmp(sign, 'j')
    fitnessFunc = @(x) (-1)*fitnessFunc(x);
end
useMOO = input('Mehrzieloptimierung? (j/n): ','s');
A0_min = input('Minimaler Winkel: ');
W0_min = input('Minimale Zahnbreite: ');
W0_max = input('Maximale Zahnbreite: '); 
L0_min = input('Minimale Zahnlaenge: ');
L0_max = input('Maximale Zahnlaenge: ');
R1_min = input('Minimaler Radius R1: ');
R2_min = input('Minimaler Radius R2: ');
R_max = input('Maximaler Radius R1 und R2: ');
disp(''); disp('-----------------');

% Optimierung
erg = optimizor(fitnessFunc, useMOO, nTest, nVar, stellen, A0_min, ...
    W0_min, W0_max, L0_min, L0_max, R1_min, R2_min, R_max);

% Suche nach besten Individuen
[a,i] = max(erg(:,6)); % Maximum suchen
k = 1; % Zaehler
best(k,:) = erg(i,:); % verschiedene Maxima abspeichern
for j = 1:nTest
    if erg(j,6) == a
       best(k,:) = erg(j,:); 
       k = k + 1;
    end
end

% Anzeige
disp('-----------------');
disp('Beste Individuen');
disp(best);
disp('-----------------');

% Datei schreiben
csvwrite('best.dat', best); 
disp('Beste Individuen in best.dat geschrieben...');
