function [] = runrapidminer(pathToRapidminer, pathToProcess, processName)
% call rapidminer from matlab, automagically - e.g.:
% runrapidminer('C:\Program Files\RapidMiner\RapidMiner Studio\scripts\', ...
% 'E:\Dropbox\University\Bachelor_7_2014-SS_BA\01_Bachelorarbeit\06_Parser\testing\','testprocess.rmp')

% Standard file path
if isempty(pathToRapidminer)
   pathToRapidminer = 'C:\Program Files\RapidMiner\RapidMiner Studio\';
end

% adding script folder
pathToRapidminer = [pathToRapidminer, 'scripts\'];

% some variables
rapidminer = 'rapidminer-batch.bat';
startVal = '-f';

% system call
call =  ['"', pathToRapidminer, rapidminer, '"' ' ', startVal, ' ', '"', pathToProcess, processName, '"'];
system(call)

end
