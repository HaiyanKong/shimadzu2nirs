function cleanup(dirnameInstall, dirnameApp)

platform = setplatformparams();

if ~exist('dirnameApp','var') | isempty(dirnameApp)
    dirnameApp = ffpath('setpaths.m');
end
if dirnameApp(end)~='/' & dirnameApp(end)~='\'
    dirnameApp(end+1)='/';
end

if ~exist('dirnameInstall','var') | isempty(dirnameInstall)
    if exist('./INSTALL','dir')
        dirnameInstall = [pwd, '/INSTALL'];        
    else
        dirnameInstall = pwd;
    end
end
if dirnameInstall(end)~='/' & dirnameInstall(end)~='\'
    dirnameInstall(end+1)='/';
end

if exist([dirnameInstall, 'homer2_install'],'dir')
    rmdir([dirnameInstall, 'homer2_install'],'s');
end
for ii=1:length(platform.atlasviewer_exe(1))
    if exist([dirnameInstall, platform.atlasviewer_exe{ii}],'file')==2
        delete([dirnameInstall, platform.atlasviewer_exe{ii}]);
    elseif exist([dirnameInstall, platform.atlasviewer_exe{ii}],'dir')==7
        rmdir([dirnameInstall, platform.atlasviewer_exe{ii}], 's');
    end
end
for ii=1:length(platform.homer2_exe(1))
    if exist([dirnameInstall, platform.homer2_exe{ii}],'file')==2
        delete([dirnameInstall, platform.homer2_exe{ii}]);
    elseif exist([dirnameInstall, platform.homer2_exe{ii}],'dir')==7
        rmdir([dirnameInstall, platform.homer2_exe{ii}], 's');
    end
end

for ii=1:length(platform.setup_exe)
    if exist([dirnameInstall, platform.setup_exe{ii}],'file')==2
        delete([dirnameInstall, platform.setup_exe{ii}]);
    elseif exist([dirnameInstall, platform.setup_exe{ii}],'dir')==7
        rmdir([dirnameInstall, platform.setup_exe{ii}], 's');
    end
end
if exist([dirnameInstall, 'Buildme.log'],'file')
    delete([dirnameInstall, 'Buildme.log']);
end
if exist([dirnameApp, 'Buildme.log'],'file')
    delete([dirnameApp, 'Buildme.log']);
end
if exist([dirnameInstall, 'mccExcludedFiles.log'],'file')
    delete([dirnameInstall, 'mccExcludedFiles.log']);
end
if exist([dirnameApp, 'mccExcludedFiles.log'],'file')
    delete([dirnameApp, 'mccExcludedFiles.log']);
end

