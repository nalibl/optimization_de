function [acq_im] = acquire_imag_green(cam,MemId,Bits,Width,Height)
%% From Thorlabs support documentation
% Acquire image
cam.Acquisition.Freeze(uc480.Defines.DeviceParameter.Wait);
% Copy image from memory
[~, tmp] = cam.Memory.CopyToArray(MemId);
% Reshape image
acq_im = reshape(uint8(tmp), [Bits/8, Width, Height]);
acq_im = acq_im(1:3, 1:Width, 1:Height);
acq_im = permute(acq_im, [3,2,1]);
% Only green image is of interest
acq_im = acq_im(:,:,2);
end