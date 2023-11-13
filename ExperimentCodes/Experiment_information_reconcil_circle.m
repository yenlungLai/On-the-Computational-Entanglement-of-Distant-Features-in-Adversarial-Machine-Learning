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
nter = 40;

w1 = randn(imageSize);
w2 = randn(imageSize);

ii = 1;

u = reshape(w1, k, 1)';
v = reshape(w2, k, 1)';

ell = length(v);
rmat = randn(n, ell);

% Create a blank binary image (all zeros)
binaryImage = zeros(imageSize);

% Define circle parameters
centerX = imageSize(2) / 2; % X-coordinate of the circle's center
centerY = imageSize(1) / 2; % Y-coordinate of the circle's center
radius = min(imageSize) / 4; % Radius of the circle (adjust as needed)

% Create a meshgrid of X and Y coordinates
[X, Y] = meshgrid(1:imageSize(2), 1:imageSize(1));

% Use the equation of a circle to set pixels inside the circle to 1 (white) and pixels outside the circle to 0 (black)
circlePixels = (X - centerX).^2 + (Y - centerY).^2 <= radius^2;

% Assign the circle pixels to the binary image
binaryImage(circlePixels) = 1;
imshow(binaryImage)
while ii <= nter
    ii
    % Encoding for u
    [reduced_codeword1, reduced_matrix] = Encoding(u',n,k);
    fu1 = reduced_codeword1';
    u = fu1;

    rmat = reduced_matrix;
    % Encoding for v
    fu2 = rmat * (v');
    fu2 = fu2';
    v = fu2;

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





