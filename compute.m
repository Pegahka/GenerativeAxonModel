clear;
close all;
mfile_name          = mfilename('fullpath');
[pathstr,name,ext]  = fileparts(mfile_name);
cd(pathstr);
mkdir('out');
cd 'compute';
mainFull;
cd '..';
