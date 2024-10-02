
mglOpen;

% The script will set the screen to black, with the exception
% of the red fixation dot in the center.
% The screen will stay in this state until the user presses
% any key, at which point it leaves one half of the screen
% black, and present on the other half an 8Hz flickering checkerboard.
% Then, it will return to the black screen, and then back to the
% flicker, and so on. 
% This will continue for some pre-defined period of time. At the
% end of this period, the screen will return to black.

% Properties of the stimulus
checkSizeDeg = 2.5;
flickFreqHz = 8;

% Properties of stimulus timing
halfCycleDurSecs = 39;
totalStimCycles = 5;

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

% Wait for user to press any key to start
pause;

% Set cycles at 1
cycles = 1;

while cycles <= totalStimCycles
    tic;
    while toc < halfCycleDurSecs
        mglBltTexture(tex1,[1 0],-1);
        mglPoints2(0, 0, 0.5, [1 0 0],true);
        mglFlush;
        mglWaitSecs(stimTimeSecs)
        mglBltTexture(tex2,[1 0],-1);
        mglPoints2(0, 0, 0.5, [1 0 0],true);
        mglFlush;
        mglWaitSecs(stimTimeSecs)
    end
    tic;
        while toc < halfCycleDurSecs
        mglClearScreen(0);
        mglPoints2(0, 0, 0.5, [1 0 0],true);
        mglFlush;
        end
    cycles = cycles + 1; 
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




