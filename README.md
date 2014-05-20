# draw-package package

Simple package for drawing Ascii-art in your text file.

This is more like an experiment for me, for learning, but feel welcome to comment
or even contribute to this project.

Currently, drawing is pretty destructive so don't draw inside text
or other art you want to keep :)...

Adding lines or moving to line that is shorter than previous line, will result
that the line will be filled with canvas.

Ctrl-Alt    Up	- draw up
			Down  - draw down
			Left  - draw left
			Right - draw right
			.     - create canvas line (fill with 80 .)

issues : Problem with tab / space behavior in Atom. Or the author doesn't fully
understand it - this would get rid of the dot canvas.

No tests written yet.


![A screenshot of your spankin' package](https://f.cloud.github.com/assets/69169/2290250/c35d867a-a017-11e3-86be-cd7c5bf3ff9b.gif)
