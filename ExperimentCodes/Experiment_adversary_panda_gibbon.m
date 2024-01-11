% Define the size of the image
clear all
imageSize = [50, 50]; % Adjust the size as needed

% Create a folder to save the images (replace 'folder_path' with your desired path)
folder_path = 'image_recov';
if ~exist(folder_path, 'dir')
    mkdir(folder_path);
end

k = (imageSize(1) * imageSize(2));
n = k + 1000;
nter = 100;   % nter = encoding time  step (t)
noise_order=100;  % alpha noise level





% Define the path to your JPEG image file
imageFilePath1 = 'panda.png';
imageFilePath2 = 'gibbon.png';
% Read the JPEG image
pandaImage = imread(imageFilePath1);
gibbonImage = imread(imageFilePath2);
% Convert the image to grayscale
pandagrayImage = rgb2gray(pandaImage);
gibbongrayImage = rgb2gray(gibbonImage);
% Apply a threshold to create a binary image
% You can adjust the threshold level as needed (0.5 is a common starting point)
pandagrayImage = imresize(pandagrayImage,imageSize);
gibbongrayImage = imresize(gibbongrayImage,imageSize);
gibbongrayImagedouble=double(gibbongrayImage);
pandagrayImagedouble=double(pandagrayImage);

wpanda = normalize(pandagrayImagedouble);
w1 = randn(imageSize);
w2=normalize(gibbongrayImagedouble);

u = reshape(w1, k, 1)';
v = reshape(w2, k, 1)';


ii = 1;
ell = length(u);
rmat = randn(n, ell);


while ii <= nter

    ii
     % Encoding for u
        [fu1,filter1]=Encoding(u',n,k);
         filterset{ii}=filter1;
        fu1=fu1';
        u=fu1;


    % Encoding for v   
        fu2=filter1*(v');
        fu2=fu2';
        v=fu2;

    c1_dec = reshape(v, imageSize);

    ii = ii + 1;
    
    u = u / norm(u);  % Normalize the vector
    v = v / norm(v);  % Normalize the vector


   % entangled pair
    c1_codeword = reshape(noise_order*u, imageSize);  
    c2_codeword = reshape(noise_order*v, imageSize);



    encodedmsg = ((c1_codeword))+(wpanda);   % encoded image y
    decodedmsg = (encodedmsg-((c2_codeword))); % decoded image m
   

    % Save the fu2 image in the folder with a unique filename
    filename = fullfile(pwd, ['\image_recov\fu2_image_', num2str(ii), '.png']);
    filename2 = fullfile(pwd, ['\image_recov\encode_', num2str(ii), '.png']);
    
    decodedmsg=imresize(decodedmsg,[50,50]);
    imwrite(decodedmsg, filename);
  
    %show decoded image
    imshow(decodedmsg)   
end









function [yfil,frmat]=Encoding(x,n,k)
ell=length(x);

rmat=randn(n,ell);
% rmat=orth(rmat);
y=rmat*x;
absy=abs(y);
[sorted_data, sortedindex ]= sort(absy, 'descend');


topindex=(sortedindex(1:k));
frmat=rmat(topindex,:);
yfil=y(topindex);

end








