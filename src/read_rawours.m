%read raw file
%input: file name of the file
%output: 
%   width/height/depth: size of the volume data
%   scantype: unused
%   vdata: volume data of the ultrasound data

function [width, height, depth, scantype, vdata]=read_rawours(filename)

fid=fopen(filename, 'r');

if (fid<=0)
    errordlg('can''t open the file');
end;



width=(fread(fid, 1, 'uint32'));
height=(fread(fid, 1, 'uint32'));
depth=(fread(fid, 1, 'uint32'));

scantype=0;%fread(fid, 1, 'uint32');

vdata=uint8(zeros(height, width, depth));
data=uint8(zeros(1, height*width));
for i=1:depth
    data=uint8(fread(fid, height*width, 'uint8'));
    temp=reshape(data, width, height);
    vdata(:,:,i)=uint8(flipud(temp'));
end;
fclose(fid);
