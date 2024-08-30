% Load and convert the image to grayscale
image = imread('image.png'); % Replace 'image.png' with your image file
if size(image, 3) == 3
    image = rgb2gray(image);
end

% Convert the image to double for SVD
image = double(image);

% Perform Singular Value Decomposition
[U, S, V] = svd(image);

% Select the number of singular values to keep (rank-k approximation)
k = 50; % Adjust 'k' based on the desired compression level

% Reconstruct the image using the top k singular values
compressed_image = U(:, 1:k) * S(1:k, 1:k) * V(:, 1:k)';

% Display the original and compressed images
figure;
subplot(1, 2, 1);
imshow(uint8(image));
title('Original Image');

subplot(1, 2, 2);
imshow(uint8(compressed_image));
title(['Compressed Image with k = ' num2str(k)]);

% Save the compressed image
imwrite(uint8(compressed_image), 'compressed_image.png');
