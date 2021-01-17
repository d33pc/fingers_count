% Subtracting background from foreground 

function [bgs_out] = bg_subtract(bg,fg)
    [bg_hsv] = round(rgb2hsv(bg));
    [fg_hsv] = round(rgb2hsv(fg));

    out = bitxor(bg_hsv, fg_hsv);
    out = rgb2gray(out);

    bw = out > 0;
    
    % median filter to remove salt & pepper noise. 
    med_fil_img = medfilt2(bw, [5 5]);

    [L, num] = bwlabel(med_fil_img);
    stats = regionprops(L,'all');

    for i=1:num
        dd = stats(i).Area;
        % removing small blobs in the final image.
        if (dd<500)
            L(L==i) = 0;
            num = num - 1;
        else
        end
    end
    [bgs_out, num2] = bwlabel(L);
end