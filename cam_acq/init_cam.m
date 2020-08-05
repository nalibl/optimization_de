function [acq_im_fun,set_exp_ms,set_gain,cam] = init_cam()
%% From Thorlabs support documentation
% Bugs - can only run init_cam once, if failed, restart MATLAB and
% reconnect the camera.

% Run once per MATLAB instance!
% Add NET assembly 
% May need to change specific location of library
dll_path = mfilename('fullpath');
NET.addAssembly([dll_path '\\cam_acq\\uc480DotNet.dll');
% Create camera object handle
cam = uc480.Camera;
% Open the 1st available camera
cam.Init(0);
% Set display mode to bitmap (DiB)
cam.Display.Mode.Set(uc480.Defines.DisplayMode.DiB);
% Set color mode to 8-bit RGB
cam.PixelFormat.Set(uc480.Defines.ColorMode.RGBA8Packed);
% Set trigger mode to software (single image acquisition)
cam.Trigger.Set(uc480.Defines.TriggerMode.Software);
% Allocate image memory
[~, MemId] = cam.Memory.Allocate(true);
% Obtain image information
[~, Width, Height, Bits, ~] = cam.Memory.Inquire(MemId);
% Acquisition struct
acq_im_fun = @() acquire_imag_green(cam,MemId,Bits,Width,Height);
set_exp_ms = @(exp) cam.Timing.Exposure.Set(exp);
set_gain = @(gain) cam.Gain.Hardware.Scaled.SetMaster(gain);
end