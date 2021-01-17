bg = capture_bg();
pause(2);
% Create axes control.
handleToAxes = axes();
% Get the handle to the image in the axes.
hImage = image(zeros(720,1280,'uint8'));
% Reset image magnification. Required if you ever displayed an image
% in the axes that was not the same size as your webcam image.
hold off;
axis auto;
axis on;
% Enlarge figure to full screen.
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
cam = webcam;
preview(cam,hImage)
hold on
thisBB = [200 130 360 370];
% Creating bounding box in Frame. 
rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)], 'EdgeColor','r','LineWidth',2 )

% Processing hand image and giving output, no. of images.
for i = 1:200
    capture = snapshot(cam);
    fg = imcrop(capture, [200 130 360 370]);
    bgs_img = bg_subtract(bg, fg);
    
    % Horizontal ractangular structuring element for removing fingers 
    st = strel('rectangle', [5 50]);
    palm = imopen(bgs_img, st);
    
    % Subtracting palm from whole hand to extract fingers
    fingers = bgs_img - palm;
%     st = strel('disk', 5);
%     fingers = imopen(fingers, st);
    [L,n] = bwlabel(fingers);
    if (n>5)
        n = 5;
    end
    
    title(sprintf('Number of Fingers: %d', n));
    imshow(fingers)
end
clear cam;
close all;