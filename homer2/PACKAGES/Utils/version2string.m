function [verstr, V] = version2string()

V = getVernum();
if str2num(V{2})==0
    verstr = sprintf('v%s', [V{1}]);
else
    verstr = sprintf('v%s', [V{1} '.' V{2}]);
end

if length(V)>2
    verstr = sprintf('%s, %s', verstr, V{3});
end    