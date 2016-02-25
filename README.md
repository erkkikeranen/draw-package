# draw-package for Atom

Simple package for drawing Ascii-art in your text file.

This is more like an experiment for me, for learning, but feel welcome to comment
or even contribute to this project.

Currently, drawing is pretty destructive so don't draw inside text
or other art you want to keep :)...

Adding lines or moving to line that is shorter than previous line, will result
that the line will be filled with canvas.

Ctrl-Alt    i	- draw up
			k  - draw down
			j  - draw left
			l - draw right
			u     - create canvas line (fill with 80 x .)
			o	 - finish selection (replace . with whitespace)

issues : Problem with tab / space behavior in Atom. Or the author doesn't fully
understand it - this would get rid of using the dot canvas. Probably some new after removing deprecations...

No tests written yet.


![A screenshot of draw-package](https://raw.githubusercontent.com/wiki/erkkikeranen/draw-package/draw-package-demo-movie.gif)
