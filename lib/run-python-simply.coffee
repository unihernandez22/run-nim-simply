{CompositeDisposable} = require 'atom'
child_process = require 'child_process'
path = require 'path'

module.exports = RunPythonSimply =
  subscriptions: null
  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'run-python-simply:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->


  toggle: ->
    editor = atom.workspace.getActiveTextEditor()
    if editor
      file = editor.buffer.file
      if file
        fileInfo = path.parse(file.path)
        if fileInfo.ext != ".py"
          atom.notifications.add("warning", "Current file is not a python source file")
        else
          editor.save()
          @run(file.path)
      else
        atom.notifications.add("info", "No source file to run")

  run: (file)->
    command = atom.config.get('run-python-simply.command')
    args = command.split(" ").concat(['python', __dirname + path.sep + 'exec.py', file])
    process = child_process.spawn("start", args, {
      shell: true
      detached: true
    })
    process.unref()

  config:
    command:
      title: "Command Prompt"
      type: 'string'
      default: 'cmd /c'
      enum: [
        {value: 'cmd /c', description: 'Command Line Prompt'}
        {value: 'powershell -command', description: 'Powershell'}
      ]
