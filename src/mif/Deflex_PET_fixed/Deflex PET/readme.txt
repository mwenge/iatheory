Deflex for the PET. The original version is lost to time so i remade it.

No idea why but it's a right pain in the tits to get it in a state where I can share it.

Trying to make a .TAP and using SAVE from BASIC will save but it'll be corrupt when it reloads.

Snapshots seem flaky as hell and often load up in a frozen state or with the wrong keyboard map.

This procedure with these files SEEMS to work on VICE/xpet 3.6.0
(GTK3 3.24.31, GLib 2.70.2, Cairo 1.17.4, Pango 1.50.2) as copied from the about popup in the emu.

- Run xpet, it comes up in an 80 column mode with 31743 bytes free
- Go to "load settings from" and load in the deflex.ini file. This should change the screen to 40 columnn (and black and white because that was what the PET I learned on looked like) but it'll be frozen.
- Reset the machine and it'll come back to 7167 bytes free boot screen
- Go to "load snapshot image" and load deflex.vsf

it should come up stopped and hopefully with the cursor flashing and HOPEFULLY not with the wrong bloody keyboard map.
Just type RUN to enjoy this simple ass game which has been far too much of a papaver to get into a sharable form for some reason.

Additional - I just fixed a little bug that could make the targets appear in the wrong place or not at all. And then it was a total ballache to get another working snapshot file. This one SHOULD work ok and without the bug.


