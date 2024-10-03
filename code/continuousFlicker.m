mglOpen;

% The script will set the screen to black, with the exception
% of the red fixation dot in the center.
% The screen will stay in this state until the user presses
% any key, at which point it leaves one half of the screen
% black, and present on the other half an 8Hz flickering checkerboard.
% After some pre-defined period of time, the script will return to the
% original state of black with a fixation dot.

% Properties of the stimulus
checkSizeDeg = 2.5;
flickFreqHz = 8;

% Define the physical distance and [width height] of the monitor. These
% values correspond to a screen that is ~16 degrees wide and 12 degrees
% tall.
mglVisualAngleCoordinates(57,[16 12]);
mglSetParam('visualAngleSquarePixels',1);
mglClearScreen(0);

% Create the opposite phase checkerboard stimuli
grating1 = mglMakeGrating(7,12,1.5,45,0);
grating2 = mglMakeGrating(7,12,1.5,135,0);
rect1 = 255*(sign(grating1/2+grating2/2));
rect2 = 255*(sign(-grating1/2-grating2/2));
tex1 = mglCreateTexture(rect1);
tex2 = mglCreateTexture(rect2);

% Set the screen to black, with the exception of the red fixation dot
mglClearScreen(0);
mglPoints2(0, 0, 0.5, [1 0 0], true);
mglFlush;

% Calculate the duration of each stimulus presentation
stimTimeSecs = 0.5/flickFreqHz;

% Set stimulus duration in seconds
stimulusDuration = (11*60)+30;

% Start timer
tic;

while toc < stimulusDuration
    mglBltTexture(tex1,[1 0],-1);
    mglPoints2(0, 0, 0.5, [1 0 0],true);
    mglFlush;
    mglWaitSecs(stimTimeSecs)
    mglBltTexture(tex2,[1 0],-1);
    mglPoints2(0, 0, 0.5, [1 0 0],true);
    mglFlush;
    mglWaitSecs(stimTimeSecs)
end

% Set duration of final black screen with fixation dot
screenDuration = 5;

% Start another timer for final black screen 
tic;

while toc < screenDuration
    mglClearScreen(0);
    mglPoints2(0, 0, 0.5, [1 0 0],true);
    mglFlush;
end

% Cleanup
mglDeleteTexture(tex1);
mglDeleteTexture(tex2);
mglClose; % Close MGL




