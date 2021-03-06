clear all; close all; clc

savepath = 'Z:\Experiments\Results\20120827-wake view\Images\re1000';
re = 1000;
files = dir('*.im7');

for i = 1:length(files)

  data = readimx(files(i).name);

   % Determine which images contain useful data and process only those
   data64 = double(data.Data)/65535;
   cut = data64 > 0.01;
   if sum(sum(cut)) >= 200
       img = imrotate(imadjust(data.Data),-90); % Adjust contrast and then rotate image
       imwrite(img,fullfile(savepath, strcat('smokevis', '_re', num2str(re), '_', num2str(i), '.png')),'png');
   end
      
end
  


