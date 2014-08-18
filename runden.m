function [rundWert] = runden(wert, stellen)
% rundet wert auf angegebene Anzahl stellen hinter dem Komma
rundWert = round((wert)*(10^stellen))/(10^stellen);
end
