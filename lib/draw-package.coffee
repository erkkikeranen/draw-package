# to do
#
# [ok] add commant to draw dot lines as drawing background (create canvas)
# add command to change dots in selection to whitespace (finish)
# [ok] modify addlines to dotify line till end
# [ok] modify upline so that it will extend length of line
# [ok] bug : moving up/down after left shifts left
# later configuriation mode panel

{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->

      @subscriptions = new CompositeDisposable
      @subscriptions.add atom.commands.add 'atom-workspace',
        "draw-package:drawUp": => @drawUp()
      @subscriptions.add atom.commands.add 'atom-workspace',
        "draw-package:drawDown": => @drawDown()
      @subscriptions.add atom.commands.add 'atom-workspace',
        "draw-package:drawLeft": => @drawLeft()
      @subscriptions.add atom.commands.add 'atom-workspace',
        "draw-package:drawRight": => @drawRight()
      @subscriptions.add atom.commands.add 'atom-workspace',
        "draw-package:drawCanvas": => @drawCanvas()
      @subscriptions.add atom.commands.add 'atom-workspace',
        "draw-package:finishCanvas": => @finishCanvas()

    drawUp: ->

      console.log ('draw');
      editor = atom.workspace.getActiveTextEditor()

      # get current cursor position

      cursorPosition = editor.getCursorBufferPosition().toArray()
      y = cursorPosition[0];
      x = cursorPosition[1];

      # if cursor was on first line, then add one line above:

      if y is 0
        editor.moveToBeginningOfLine()
        editor.insertText('\n')
        editor.moveUp(1)
        if x > 0
          editor.insertText('.') for i in [0..(x-1)]
        editor.selectLeft()
        editor.insertText('#')
        editor.insertText(".") for i in [x..80]
        editor.moveLeft(1) for i in [80..x]

      # if cursor was not on first line :

      else if y > 0
        editor.moveUp()

        cursorPositionAtNewLine = editor.getCursorBufferPosition().toArray()
        x2 = cursorPositionAtNewLine[1];

        if x > x2

          editor.insertText(".") for i in [x2..(x-1)]
          editor.selectLeft()
          editor.insertText('#')
          editor.insertText(".") for i in [x..80]
          editor.moveLeft() for i in [80..x]

        if x2 == x
          editor.selectLeft()
          editor.insertText('#')

# drawDown draws down, and inserts new line if end of file.

    drawDown: ->

      editor = atom.workspace.getActiveTextEditor()
      cursorPosition = editor.getCursorBufferPosition().toArray()
      y = cursorPosition[0];
      x = cursorPosition[1];

      # if already at last line add new line
      if editor.getLineCount() <= (y+1)
          editor.moveToEndOfLine()
          editor.insertText("\n")

          if x >= 1
              editor.insertText(".") for i in [1..x]
          if x > 0
              editor.selectLeft()

          editor.insertText('#')
          editor.insertText(".") for i in [x..80]
          editor.moveLeft() for i in [80..x]

      else
          editor.moveDown()

          cursorPositionAtNewLine = editor.getCursorBufferPosition().toArray()
          x2 = cursorPositionAtNewLine[1];

          if x > x2

              editor.insertText(".") for i in [x2..(x-1)]
              editor.selectLeft()
              editor.insertText('#')
              editor.insertText(".") for i in [x..80]
              editor.moveLeft() for i in [80..x]

          else
              editor.selectLeft()
              editor.insertText('#')


# drawLeft function draws to the left

  drawLeft: ->

      editor = atom.workspace.getActiveTextEditor()
      cursorPosition = editor.getCursorBufferPosition().toArray()
      y = cursorPosition[0];
      x = cursorPosition[1];

      if x > 0
          editor.moveLeft()
          editor.moveLeft()
          editor.selectRight()

          editor.insertText('#')

# drawRight function draws to the right

    drawRight: ->

      editor = atom.workspace.getActiveTextEditor()
      editor.selectRight()

      if editor.getSelectedText().toString() is '\n'
          editor.selectLeft()

      editor.insertText('#')

# drawCanvas function draws dots on next line, because of Atom
# funky behavior with spaces and tabs.

    drawCanvas: ->

      editor = atom.workspace.getActiveTextEditor()

      editor.moveToEndOfLine()
      editor.insertText("\n")

      editor.insertText(".") for i in [0..80]
      editor.moveToBeginningOfLine()

    finishCanvas: ->


      editor = atom.workspace.getActiveTextEditor()

      selection = editor.getSelectedText().toString()

      finished = selection.replace(/[.]/g, " ")

      editor.insertText(finished)
