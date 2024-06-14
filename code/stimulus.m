mglOpen;

% Properties of the stimulus
checkSizeDeg = 2.5;
flickFreqHz = 8;

% Define the physical distance and [width height] of the monitor. These
% values correspond to a screen that is ~16 degrees wide and 12 degrees
% tall.
mglVisualAngleCoordinates(57,[16 12]);
mglSetParam('visualAngleSquarePixels',1);
mglClearScreen(0.5);

% Create the opposite phase checkerboard stimuli
grating1 = mglMakeGrating(7,12,1.5,45,0);
grating2 = mglMakeGrating(7,12,1.5,135,0);
rect1 = 255*(sign(grating1/2+grating2/2));
rect2 = 255*(sign(-grating1/2-grating2/2));
tex1 = mglCreateTexture(rect1);
tex2 = mglCreateTexture(rect2);

% Present the flickering checkerboard
mglClearScreen(0.5);
stimTimeSecs = 0.5/flickFreqHz;

for i = 1:20
  mglBltTexture(tex1,[1 0],-1);
  mglPoints2(0, 0, 0.5, [1 0 0],true);
  mglFlush;
  mglWaitSecs(stimTimeSecs)
  mglBltTexture(tex2,[1 0],-1);
  mglPoints2(0, 0, 0.5, [1 0 0],true);
  mglFlush;
  mglWaitSecs(stimTimeSecs)
end