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
nter = 100;

w1 = randn(imageSize);
w2 = randn(imageSize);

ii = 1;

u = reshape(w1, k, 1)';
v = reshape(w2, k, 1)';

ell = length(v);
rmat = randn(n, ell);
rmat2=randn(k,k);



% Define the path to your JPEG image file
imageFilePath = 'pc.png';

% Read the JPEG image
originalImage = imread(imageFilePath);

% Convert the image to grayscale
% grayImage = rgb2gray(originalImage);

% Apply a threshold to create a binary image
% You can adjust the threshold level as needed (0.5 is a common starting point)
binaryImage = originalImage>0;
binaryImage = imresize(binaryImage,imageSize);
while ii <= nter
    ii
     % Encoding for u
        [fu1,filter1]=Encoding(u',n,k);
        fu1=fu1';
        u=fu1;


    if ii==1
        v=rmat2*v';
        v=v';
    else
    % Encoding for v   
        fu2=filter1*(v');
        fu2=fu2';
        v=fu2;
    end


    ii = ii + 1;
    
    fu1 = sign(u);
    fu2 = sign(v);


   
    c1_codeword = reshape(fu1, imageSize);
    c2_codeword = reshape(fu2, imageSize);

    encodedmsg = mod(double(c1_codeword(:,:) == 1) + binaryImage, 2);
    decodedmsg = mod(double(c2_codeword(:,:) == 1) + encodedmsg, 2);

    % Save the fu2 image in the folder with a unique filename
    filename = fullfile(pwd, ['\image_recov\fu2_image_', num2str(ii), '.png']);
    imwrite(decodedmsg, filename);
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







function [yfil,frmat]=Encoding2(rmat,x,k)

y=rmat*x;
absy=abs(y);
[sorted_data, sortedindex ]= sort(absy, 'descend');


topindex=(sortedindex(1:k));
frmat=rmat(topindex,:);
yfil=y(topindex);

end





