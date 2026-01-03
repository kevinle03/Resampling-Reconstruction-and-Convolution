%% (a)
killarney_pic = imread("KillarneyPic.png");
whos("killarney_pic")
%% (b)
killarney_pic_double = im2double(killarney_pic);
figure
imshow(killarney_pic_double)
%% (c)
rate_reduction_factor = 5;
% impulse sampling
impulse_sample = zeros(size(killarney_pic_double));
impulse_sample(1:rate_reduction_factor:end, 1:rate_reduction_factor:end) = 1;
killarney_pic_impulse_sampled = impulse_sample.*killarney_pic_double;
figure
imshow(killarney_pic_impulse_sampled)
% downsampling
killarney_pic_downsampled = killarney_pic_double(1:rate_reduction_factor:end, 1:rate_reduction_factor:end);
figure
imshow(killarney_pic_downsampled)
% zero-order hold reconstruction
killarney_pic_ZOH = zeros(size(killarney_pic_double));
for i=1:size(killarney_pic_downsampled,1) % access rows
    for j=1:size(killarney_pic_downsampled,2) % access columns
        i_start = i*rate_reduction_factor-(rate_reduction_factor-1);
        i_end = i*rate_reduction_factor;
        j_start = j*rate_reduction_factor-(rate_reduction_factor-1);
        j_end = j*rate_reduction_factor;
        if i == size(killarney_pic_downsampled,1)
            i_end = size(killarney_pic_ZOH,1);
        end
        if j == size(killarney_pic_downsampled,2)
            j_end = size(killarney_pic_ZOH,2);
        end
        killarney_pic_ZOH(i_start:i_end,j_start:j_end) = killarney_pic_downsampled(i,j);
    end
end
figure
imshow(killarney_pic_ZOH)
% first_order hold reconstruction
killarney_pic_FOH = zeros(size(killarney_pic_double));
% interpolate every rate_reduction_factor number of rows first
for i=1:size(killarney_pic_downsampled,1) % access rows
    for j=1:size(killarney_pic_downsampled,2) % access columns
        if j == size(killarney_pic_downsampled, 2)
            % keep constant for last column
            killarney_pic_FOH(i*rate_reduction_factor-(rate_reduction_factor-1),j*rate_reduction_factor-(rate_reduction_factor-1):end) = killarney_pic_downsampled(i,j);
        else
            row_interpolation = linspace(killarney_pic_downsampled(i,j),killarney_pic_downsampled(i,j+1),6);
            killarney_pic_FOH(i*rate_reduction_factor-(rate_reduction_factor-1),j*rate_reduction_factor-(rate_reduction_factor-1):j*rate_reduction_factor) = row_interpolation(1,1:5);
        end
    end
end
% interpolate all columns
for j=1:size(killarney_pic_FOH,2) % access all columnso
    for i=1:size(killarney_pic_downsampled,1) % access rows
        if i == size(killarney_pic_downsampled,1)
            % keep constant for last row
            killarney_pic_FOH(i*rate_reduction_factor-(rate_reduction_factor-1):end,j) = killarney_pic_FOH(i*rate_reduction_factor-(rate_reduction_factor-1),j);
        else
            column_interpolation = linspace(killarney_pic_FOH(i*rate_reduction_factor-(rate_reduction_factor-1),j),killarney_pic_FOH(i*rate_reduction_factor+1,j),6);
            killarney_pic_FOH(i*rate_reduction_factor-(rate_reduction_factor-1):i*rate_reduction_factor,j) = column_interpolation(1,1:5).';
        end   
    end
end
figure
imshow(killarney_pic_FOH)

%% (d) Calculate PSNR values (for ranking fidelity)
psnr_impulse = psnr(killarney_pic_impulse_sampled, killarney_pic_double);
psnr_ZOH = psnr(killarney_pic_ZOH, killarney_pic_double);
psnr_FOH = psnr(killarney_pic_FOH, killarney_pic_double);

fprintf('PSNR between original and impulse sampled image: %.2f dB\n', psnr_impulse);
fprintf('PSNR between original and ZOH reconstructed image: %.2f dB\n', psnr_ZOH);
fprintf('PSNR between original and FOH reconstructed image: %.2f dB\n', psnr_FOH);