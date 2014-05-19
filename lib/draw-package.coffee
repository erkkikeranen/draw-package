# to do
#
# [ok] add commant to draw dot lines as drawing background (create canvas)
# add command to change dots in selection to whitespace (finish)
# modify upline so that it will extend length of line
#
# later configuriation mode panel


module.exports =

    activate: ->
        atom.workspaceView.command "draw-package:drawUp", => @drawUp()
        atom.workspaceView.command "draw-package:drawDown", => @drawDown()
        atom.workspaceView.command "draw-package:drawLeft", => @drawLeft()
        atom.workspaceView.command "draw-package:drawRight", => @drawRight()
        atom.workspaceView.command "draw-package:drawCanvas", => @drawCanvas()

    drawUp: ->

        editor = atom.workspace.activePaneItem
        cursorPosition = editor.getCursorBufferPosition().toArray()
        y = cursorPosition[0];
        x = cursorPosition[1];

        editor.moveCursorUp()

        if y is 0
            editor.moveCursorToBeginningOfLine()
            editor.insertText('\n')
            editor.moveCursorUp()
        if x > 0
            editor.selectLeft()
            editor.insertText('#')

        if x is 0
            if editor.selectRight() is not '\n'
                editor.insertText('#')
            else editor.insertText('#')


    drawDown: ->

        editor = atom.workspace.activePaneItem
        cursorPosition = editor.getCursorBufferPosition().toArray()
        y = cursorPosition[0];
        x = cursorPosition[1];



        # if already at last line add new line
        if editor.getLineCount() <= (y+1)
            editor.moveCursorToEndOfLine()
            editor.insertText("\n")
            editor.setSoftTabs(false)

            if x >= 1
                editor.insertText(".") for i in [1..x]


            if x > 0
                editor.selectLeft()


        else
            editor.moveCursorDown()
            if x > 0
                editor.selectLeft()


        editor.insertText('#')


    drawLeft: ->

        editor = atom.workspace.activePaneItem
        cursorPosition = editor.getCursorBufferPosition().toArray()
        y = cursorPosition[0];
        x = cursorPosition[1];
        tabsize = editor.getTabLength()

        if x > 0
            editor.selectLeft()

            editor.insertText('#')
            editor.moveCursorLeft()


    drawRight: ->

        editor = atom.workspace.activePaneItem
        editor.selectRight()

        if editor.getSelectedText().toString() is '\n'
            editor.selectLeft()

        editor.insertText('#')

# 
# drawCanvas function draws dots on next line, because of Atom
# funky behavior with spaces and tabs.
#

    drawCanvas: ->

        editor = atom.workspace.activePaneItem

        editor.moveCursorToEndOfLine()
        editor.insertText("\n")

        editor.insertText(".") for i in [0..80]
        editor.moveCursorToBeginningOfLine()
