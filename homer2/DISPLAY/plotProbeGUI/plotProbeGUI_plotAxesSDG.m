%$Release 4.0
% Copyright (c) Copyright 2004 - 2006 - The General Hospital Corporation and
% President and Fellows of Harvard University.
%
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% *       Redistributions of source code must retain the above copyright
% notice, this list of conditions and the following disclaimer.
% *       Redistributions in binary form must reproduce the above copyright
% notice, this list of conditions and the following disclaimer in the
% documentation and/or other materials provided with the distribution.
% *       Neither the name of The General Hospital Corporation and Harvard
% University nor the names of its contributors may be used to endorse or
% promote products derived from this software without specific prior written
% permission.
%
% The Software has been designed for research purposes only and has not been
% reviewed or approved by the Food and Drug Administration or by any other
% agency.  YOU ACKNOWLEDGE AND AGREE THAT CLINICAL APPLICATIONS ARE NEITHER
% RECOMMENDED NOR ADVISED.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.


% --------------------------------------------------------------------
function plotProbeGUI_plotAxesSDG(handles)
%This function plots the prove geometry
%Command line call:
%plotAxes_SDG(guidata(gcbo),bool);
%
%Flags
%   newFigure- plot in new window
global hmr

SD = hmr.SD;
axesSDG = hmr.axesSDG;

axes(axesSDG);
cla
axis(axesSDG, [SD.xmin SD.xmax SD.ymin SD.ymax]);
axis(axesSDG, 'image')
set(gca,'xticklabel','')
set(gca,'yticklabel','')
set(gca,'ygrid','off')


lst=find(SD.MeasList(:,1)>0);
ml=SD.MeasList(lst,:);
lstML = find(ml(:,4)==1); %cw6info.displayLambda);


for ii=1:length(lstML) %size(ml,1)
    h = line( [SD.SrcPos(ml(lstML(ii),1),1) SD.DetPos(ml(lstML(ii),2),1)], ...
        [SD.SrcPos(ml(lstML(ii),1),2) SD.DetPos(ml(lstML(ii),2),2)] );
    set(h,'color',[1 1 1]*0.9);
    set(h,'linewidth',4);
    set(h,'ButtonDownFcn',get(axesSDG,'ButtonDownFcn'));

end


% ADD SOURCE AND DETECTOR LABELS
for idx=1:SD.nSrcs
    if ~isempty(find(SD.MeasList(:,1)==idx))
        h = text( SD.SrcPos(idx,1), SD.SrcPos(idx,2), sprintf('%c', 64+idx), 'fontweight','bold' );
        set(h,'ButtonDownFcn',get(axesSDG,'ButtonDownFcn'));
    end
end
for idx=1:SD.nDets
    if ~isempty(find(SD.MeasList(:,2)==idx))
        h = text( SD.DetPos(idx,1), SD.DetPos(idx,2), sprintf('%d', idx), 'fontweight','bold' );
        set(h,'ButtonDownFcn',get(axesSDG,'ButtonDownFcn'));
    end
end


% DRAW PLOT LINES
% THESE LINES HAVE TO BE THE LAST
% ITEMS ADDED TO THE AXES
% FOR CHANNEL TOGGLING TO WORK WITH
% cw6_sdgToggleLines()
if isfield( hmr, 'plot' )
    if ~isempty(hmr.plot)
        if hmr.plot(1,1)~=0
            hmr.color(end:size(hmr.plot,1),:)=0;
            for idx=size(hmr.plot,1):-1:1
                h = line( [SD.SrcPos(hmr.plot(idx,1),1) SD.DetPos(hmr.plot(idx,2),1)], ...
                    [SD.SrcPos(hmr.plot(idx,1),2) SD.DetPos(hmr.plot(idx,2),2)] );
                set(h,'color',hmr.color(idx,:));
                set(h,'ButtonDownFcn',sprintf('plotProbeGUI_sdgToggleLines(gcbo,[%d],guidata(gcbo))',idx));
                set(h,'linewidth',2);
                 if isfield(hmr,'plotLst') && ~SD.MeasListAct(hmr.plotLst(idx))
                     set(h,'linewidth',2);
                     set(h,'linestyle','--');
                 end


            end
        end
    end
end



