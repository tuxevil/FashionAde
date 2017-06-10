@echo off
echo %2> ftpcmd.dat
echo %3>> ftpcmd.dat
echo bin>> ftpcmd.dat
echo get %4 %5>> ftpcmd.dat
echo quit>> ftpcmd.dat

@echo on
ftp -i -d -s:ftpcmd.dat %1
del ftpcmd.dat