% Capturing background and cropping it.

function [BBimg] = capture_bg()
    % creatign webcam object.
    bg_cap = webcam();
    preview(bg_cap);
    pause(1);
    bg = snapshot(bg_cap);
    BBimg = imcrop(bg, [200 130 360 370]);
    clear bg_cap;
    close all;
end