% dod = hmrFlowInput( d )
%
% UI NAME
% Relative Flow Change
%
%
% INPUT
% d - intensity data (#time points x #data channels)
%
% OUTPUT
% dod - the intensity divided by the mean

function dod = hmrFlowInput( d )

for i = 1:size(d,2);
lst = find(isnan(d(:,i)));
d(lst,i) = nanmean(d(:,i));
clear lst
end

% percent change
dm = mean(abs(d),1);
nTpts = size(d,1);
dod = (abs(d)./(ones(nTpts,1)*dm));

if ~isempty(find(d(:)<=0))
    warning( 'WARNING: Some data points in d are zero or negative.' );
end

