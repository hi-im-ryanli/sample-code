% 
%  ______  __  __  ______  __   __       __      __       ______  ______  ______ __  __  ______  __  ______  __  __  ______    
% /\  == \/\ \_\ \/\  __ \/\ "-.\ \     /\ \    /\ \     /\  ___\/\  __ \/\  == /\ \_\ \/\  == \/\ \/\  ___\/\ \_\ \/\__  _\   
% \ \  __<\ \____ \ \  __ \ \ \-.  \    \ \ \___\ \ \    \ \ \___\ \ \/\ \ \  _-\ \____ \ \  __<\ \ \ \ \__ \ \  __ \/_/\ \/   
%  \ \_\ \_\/\_____\ \_\ \_\ \_\\"\_\    \ \_____\ \_\    \ \_____\ \_____\ \_\  \/\_____\ \_\ \_\ \_\ \_____\ \_\ \_\ \ \_\   
%   \/_/ /_/\/_____/\/_/\/_/\/_/ \/_/     \/_____/\/_/     \/_____/\/_____/\/_/   \/_____/\/_/ /_/\/_/\/_____/\/_/\/_/  \/_/   
%   
% RYAN LI, COPYRIGHT, 2016
% ELEC 345, ASSIGNMENT 6, RICE UNIVERSITY
% FILE 2, Importing the expanded files from directory, performing SIFT
% analysis, and save the workspace as 'expanded.mat'

clear all;

% I have two computers, thus I need this to accomondate two different
% enviornments
try
    run('/Users/RyanLi/Documents/vlfeat-0.9.20/toolbox/vl_setup.m')
    fileFolder_training = fullfile('/Users/RyanLi/Documents/midterm_data/midterm_data_reduced/TrainingDataset')
catch err
    disp('Mac File Folder Not Found.')
    disp('Switching to Windows Mode Now.')
    run('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\vlfeat-0.9.20\toolbox\vl_setup.m')
    fileFolder_training = fullfile('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\midterm_data\midterm_data_reduced\TrainingDataset')
end

fileFolder_training_expanded = fullfile('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\midterm_data\midterm_data_expanded\TrainingDataset')
cellSize = 8 ; % HOG Feature parameter
disp('Start Image Importing and Analyzing...')

dirOutput_training_basketball = dir(fullfile(fileFolder_training_expanded,'006.basketball-hoop','*.jpg'));
fileNames_basketball= {dirOutput_training_basketball.name}';
disp('Analyzing Basketball Hoop Set...')
for i = 1:length(fileNames_basketball)
    imageTemp = imread(fileNames_basketball{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    % SIFT
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    basketball(i,1).name = fileNames_basketball{i};
    basketball(i,1).metadata = f;
    basketball(i,1).SIFTDescriptor = single(d);
    basketball(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    basketball(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_bat = dir(fullfile(fileFolder_training_expanded,'007.bat','*.jpg'));
fileNames_bat= {dirOutput_training_bat.name}';
disp('Analyzing Bat Set...')
for i = 1:length(fileNames_bat)
    imageTemp = imread(fileNames_bat{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    bat(i,1).name = fileNames_bat{i};
    bat(i,1).metadata = f;
    bat(i,1).SIFTDescriptor = single(d);
    bat(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    bat(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_billiards = dir(fullfile(fileFolder_training_expanded,'011.billiards','*.jpg'));
fileNames_billiards= {dirOutput_training_billiards.name}';
disp('Analyzing Billiards Set...')
for i = 1:length(fileNames_billiards)
    imageTemp = imread(fileNames_billiards{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    billiards(i,1).name = fileNames_billiards{i};
    billiards(i,1).metadata = f;
    billiards(i,1).SIFTDescriptor = single(d);
    billiards(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    billiards(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_binoculars = dir(fullfile(fileFolder_training_expanded,'012.binoculars','*.jpg'));
fileNames_binoculars= {dirOutput_training_binoculars.name}';
disp('Analyzing Binoculars Set...')
for i = 1:length(fileNames_binoculars)
    imageTemp = imread(fileNames_binoculars{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    binoculars(i,1).name = fileNames_binoculars{i};
    binoculars(i,1).metadata = f;
    binoculars(i,1).SIFTDescriptor = single(d);
    binoculars(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    binoculars(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_buddha = dir(fullfile(fileFolder_training_expanded,'022.buddha-101','*.jpg'));
fileNames_buddha= {dirOutput_training_buddha.name}';
disp('Analyzing Buddha Set...')
for i = 1:length(fileNames_buddha)
    imageTemp = imread(fileNames_buddha{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    buddha(i,1).name = fileNames_buddha{i};
    buddha(i,1).metadata = f;
    buddha(i,1).SIFTDescriptor = single(d);
    buddha(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    buddha(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_butterfly = dir(fullfile(fileFolder_training_expanded,'024.butterfly','*.jpg'));
fileNames_butterfly= {dirOutput_training_butterfly.name}';
disp('Analyzing butterfly Set...')
for i = 1:length(fileNames_butterfly)
    imageTemp = imread(fileNames_butterfly{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    butterfly(i,1).name = fileNames_butterfly{i};
    butterfly(i,1).metadata = f;
    butterfly(i,1).SIFTDescriptor = single(d);
    butterfly(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    butterfly(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_cactus = dir(fullfile(fileFolder_training_expanded,'025.cactus','*.jpg'));
fileNames_cactus= {dirOutput_training_cactus.name}';
disp('Analyzing cactus Set...')
for i = 1:length(fileNames_cactus)
    imageTemp = imread(fileNames_cactus{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    cactus(i,1).name = fileNames_cactus{i};
    cactus(i,1).metadata = f;
    cactus(i,1).SIFTDescriptor = single(d);
    cactus(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    cactus(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_cake = dir(fullfile(fileFolder_training_expanded,'026.cake','*.jpg'));
fileNames_cake= {dirOutput_training_cake.name}';
disp('Analyzing cake Set...')
for i = 1:length(fileNames_cake)
    imageTemp = imread(fileNames_cake{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    cake(i,1).name = fileNames_cake{i};
    cake(i,1).metadata = f;
    cake(i,1).SIFTDescriptor = single(d);
    cake(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    cake(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_camel = dir(fullfile(fileFolder_training_expanded,'028.camel','*.jpg'));
fileNames_camel= {dirOutput_training_camel.name}';
disp('Analyzing camel Set...')
for i = 1:length(fileNames_camel)
    imageTemp = imread(fileNames_camel{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    camel(i,1).name = fileNames_camel{i};
    camel(i,1).metadata = f;
    camel(i,1).SIFTDescriptor = single(d);
    camel(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    camel(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_car = dir(fullfile(fileFolder_training_expanded,'031.car-tire','*.jpg'));
fileNames_car= {dirOutput_training_car.name}';
disp('Analyzing car Set...')
for i = 1:length(fileNames_car)
    imageTemp = imread(fileNames_car{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    car(i,1).name = fileNames_car{i};
    car(i,1).metadata = f;
    car(i,1).SIFTDescriptor = single(d);
    car(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    car(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_chess = dir(fullfile(fileFolder_training_expanded,'037.chess-board','*.jpg'));
fileNames_chess= {dirOutput_training_chess.name}';
disp('Analyzing chess Set...')
for i = 1:length(fileNames_chess)
    imageTemp = imread(fileNames_chess{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    chess(i,1).name = fileNames_chess{i};
    chess(i,1).metadata = f;
    chess(i,1).SIFTDescriptor = single(d);
    chess(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    chess(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_computer = dir(fullfile(fileFolder_training_expanded,'045.computer-keyboard','*.jpg'));
fileNames_computer= {dirOutput_training_computer.name}';
disp('Analyzing computer Set...')
for i = 1:length(fileNames_computer)
    imageTemp = imread(fileNames_computer{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    computer(i,1).name = fileNames_computer{i};
    computer(i,1).metadata = f;
    computer(i,1).SIFTDescriptor = single(d);
    computer(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    computer(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_cowboy = dir(fullfile(fileFolder_training_expanded,'051.cowboy-hat','*.jpg'));
fileNames_cowboy= {dirOutput_training_cowboy.name}';
disp('Analyzing cowboy Set...')
for i = 1:length(fileNames_cowboy)
    imageTemp = imread(fileNames_cowboy{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    cowboy(i,1).name = fileNames_cowboy{i};
    cowboy(i,1).metadata = f;
    cowboy(i,1).SIFTDescriptor = single(d);
    cowboy(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    cowboy(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_diamond = dir(fullfile(fileFolder_training_expanded,'054.diamond-ring','*.jpg'));
fileNames_diamond= {dirOutput_training_diamond.name}';
disp('Analyzing diamond Set...')
for i = 1:length(fileNames_diamond)
    imageTemp = imread(fileNames_diamond{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    diamond(i,1).name = fileNames_diamond{i};
    diamond(i,1).metadata = f;
    diamond(i,1).SIFTDescriptor = single(d);
    diamond(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    diamond(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_guitar = dir(fullfile(fileFolder_training_expanded,'063.electric-guitar','*.jpg'));
fileNames_guitar= {dirOutput_training_guitar.name}';
disp('Analyzing guitar Set...')
for i = 1:length(fileNames_guitar)
    imageTemp = imread(fileNames_guitar{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    guitar(i,1).name = fileNames_guitar{i};
    guitar(i,1).metadata = f;
    guitar(i,1).SIFTDescriptor = single(d);
    guitar(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    guitar(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_truck = dir(fullfile(fileFolder_training_expanded,'072.fire-truck','*.jpg'));
fileNames_truck= {dirOutput_training_truck.name}';
disp('Analyzing truck Set...')
for i = 1:length(fileNames_truck)
    imageTemp = imread(fileNames_truck{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    truck(i,1).name = fileNames_truck{i};
    truck(i,1).metadata = f;
    truck(i,1).SIFTDescriptor = single(d);
    truck(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    truck(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_grasshopper = dir(fullfile(fileFolder_training_expanded,'093.grasshopper','*.jpg'));
fileNames_grasshopper= {dirOutput_training_grasshopper.name}';
disp('Analyzing grasshopper Set...')
for i = 1:length(fileNames_grasshopper)
    imageTemp = imread(fileNames_grasshopper{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    grasshopper(i,1).name = fileNames_grasshopper{i};
    grasshopper(i,1).metadata = f;
    grasshopper(i,1).SIFTDescriptor = single(d);
    grasshopper(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    grasshopper(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_helicopter = dir(fullfile(fileFolder_training_expanded,'102.helicopter','*.jpg'));
fileNames_helicopter= {dirOutput_training_helicopter.name}';
disp('Analyzing helicopter Set...')
for i = 1:length(fileNames_helicopter)
    imageTemp = imread(fileNames_helicopter{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    helicopter(i,1).name = fileNames_helicopter{i};
    helicopter(i,1).metadata = f;
    helicopter(i,1).SIFTDescriptor = single(d);
    helicopter(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    helicopter(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_leopards = dir(fullfile(fileFolder_training_expanded,'129.leopards','*.jpg'));
fileNames_leopards= {dirOutput_training_leopards.name}';
disp('Analyzing leopards Set...')
for i = 1:length(fileNames_leopards)
    imageTemp = imread(fileNames_leopards{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    leopards(i,1).name = fileNames_leopards{i};
    leopards(i,1).metadata = f;
    leopards(i,1).SIFTDescriptor = single(d);
    leopards(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    leopards(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_motorbikes = dir(fullfile(fileFolder_training_expanded,'145.motorbikes','*.jpg'));
fileNames_motorbikes= {dirOutput_training_motorbikes.name}';
disp('Analyzing motorbikes Set...')
for i = 1:length(fileNames_motorbikes)
    imageTemp = imread(fileNames_motorbikes{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    motorbikes(i,1).name = fileNames_motorbikes{i};
    motorbikes(i,1).metadata = f;
    motorbikes(i,1).SIFTDescriptor = single(d);
    motorbikes(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    motorbikes(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_people = dir(fullfile(fileFolder_training_expanded,'159.people','*.jpg'));
fileNames_people= {dirOutput_training_people.name}';
disp('Analyzing people Set...')
for i = 1:length(fileNames_people)
    imageTemp = imread(fileNames_people{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    people(i,1).name = fileNames_people{i};
    people(i,1).metadata = f;
    people(i,1).SIFTDescriptor = single(d);
    people(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    people(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_refrigerator = dir(fullfile(fileFolder_training_expanded,'171.refrigerator','*.jpg'));
fileNames_refrigerator= {dirOutput_training_refrigerator.name}';
disp('Analyzing refrigerator Set...')
for i = 1:length(fileNames_refrigerator)
    imageTemp = imread(fileNames_refrigerator{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    refrigerator(i,1).name = fileNames_refrigerator{i};
    refrigerator(i,1).metadata = f;
    refrigerator(i,1).SIFTDescriptor = single(d);
    refrigerator(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    refrigerator(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_bus = dir(fullfile(fileFolder_training_expanded,'178.school-bus','*.jpg'));
fileNames_bus= {dirOutput_training_bus.name}';
disp('Analyzing bus Set...')
for i = 1:length(fileNames_bus)
    imageTemp = imread(fileNames_bus{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    bus(i,1).name = fileNames_bus{i};
    bus(i,1).metadata = f;
    bus(i,1).SIFTDescriptor = single(d);
    bus(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    bus(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_screwdriver = dir(fullfile(fileFolder_training_expanded,'180.screwdriver','*.jpg'));
fileNames_screwdriver= {dirOutput_training_screwdriver.name}';
disp('Analyzing screwdriver Set...')
for i = 1:length(fileNames_screwdriver)
    imageTemp = imread(fileNames_screwdriver{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    screwdriver(i,1).name = fileNames_screwdriver{i};
    screwdriver(i,1).metadata = f;
    screwdriver(i,1).SIFTDescriptor = single(d);
    screwdriver(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    screwdriver(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

dirOutput_training_airplanes = dir(fullfile(fileFolder_training_expanded,'251.airplanes','*.jpg'));
fileNames_airplanes= {dirOutput_training_airplanes.name}';
disp('Analyzing airplanes Set...')
for i = 1:length(fileNames_airplanes)
    imageTemp = imread(fileNames_airplanes{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    airplanes(i,1).name = fileNames_airplanes{i};
    airplanes(i,1).metadata = f;
    airplanes(i,1).SIFTDescriptor = single(d);
    airplanes(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
    airplanes(i,1).HOGDescriptor = vl_hog(imageTemp, cellSize);
end

save import_expanded.mat




















































