clear;
close all;
mfile_name          = mfilename('fullpath');
[pathstr,name,ext]  = fileparts(mfile_name); % take the address of the folder containing this script into 'pathstr' as string.
                                             % It will be called from now
                                             % on as '<main>'. It can be, 
                                             % for example,
                                             % 'C:\Users\Someone\Somefolder'
                                             % if this file is adressed as
                                             % 'C:\Users\Someone\Somefolder\compute.m'
                                             
cd(pathstr); % change current folder to the <main> (containing folder)
mkdir('out'); % create new folder named out (in <main>) (If it already exists, it is kept untouched)
cd 'compute'; %change current folder to <main>/compute (the one in the previous current folder)
mainFull; % call the mainFull.m script in the current folder (i.e., <main>/compute)
cd '..';
