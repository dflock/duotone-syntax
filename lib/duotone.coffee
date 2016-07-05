chroma = require 'chroma-js'

root = document.documentElement
presetEl = document.getElementById('duotone-syntax.preset')
colorEl = document.querySelector('.settings-view .color')
isPreset = false

module.exports =
  activate: (state) ->

    # Init
    setColors()

    # Change Preset
    atom.config.onDidChange 'duotone-syntax.preset', ({newValue, oldValue}) ->
      isPreset = true
      switch newValue
        when "Dark Sky"
          atom.config.set('duotone-syntax.unoColor', 'purple')
          atom.config.set('duotone-syntax.duoColor', 'yellow')
        when "Dark Sea"
          atom.config.set('duotone-syntax.unoColor', 'blue')
          atom.config.set('duotone-syntax.duoColor', 'green')
        when "Dark Space"
          atom.config.set('duotone-syntax.unoColor', 'purple')
          atom.config.set('duotone-syntax.duoColor', 'red')
        when "Dark Forest"
          atom.config.set('duotone-syntax.unoColor', 'green')
          atom.config.set('duotone-syntax.duoColor', 'yellow')
        when "Dark Earth"
          atom.config.set('duotone-syntax.unoColor', 'brown')
          atom.config.set('duotone-syntax.duoColor', 'orange')

    # Change Uno
    atom.config.onDidChange 'duotone-syntax.unoColor', ({newValue, oldValue}) ->
      setColors()

    # Change Duo
    atom.config.onDidChange 'duotone-syntax.duoColor', ({newValue, oldValue}) ->
      setColors()

  deactivate: ->
    unsetColors()

# Apply Colors -----------------------
# setCustomLabel = ->
#   console.log 'setColors'

# Apply Colors -----------------------
setColors = ->

  if isPreset
    isPreset = false
  else
    console.log 'setColors'
    unsetColors() # prevents adding endless properties

    _uno = atom.config.get('duotone-syntax.unoColor').toHexString()
    _duo = atom.config.get('duotone-syntax.duoColor').toHexString()

    # Color limits
    _high = chroma.mix('hsl(0,0%,100%)', _uno, 0.5);
    _mid  = _uno
    _low  = chroma.mix('hsl(0,0%,25%)', _duo, 0.25);

    # Color scales
    _scaleUno = chroma.scale([ _high, _mid, _low]).colors(5)
    _scaleDuo = chroma.scale([ _duo, _low]).padding([0, 0.33]).colors(3)

    root.style.setProperty('--uno-1', _scaleUno[0])
    root.style.setProperty('--uno-2', _scaleUno[1])
    root.style.setProperty('--uno-3', _scaleUno[2])
    root.style.setProperty('--uno-4', _scaleUno[3])
    root.style.setProperty('--uno-5', _scaleUno[4])

    root.style.setProperty('--duo-1', _scaleDuo[0])
    root.style.setProperty('--duo-2', _scaleDuo[1])
    root.style.setProperty('--duo-3', _scaleDuo[2])

    root.style.setProperty('--accent', _duo)


# Unset Colors -----------------------
unsetColors = ->
  root.style.removeProperty('--uno-1')
  root.style.removeProperty('--uno-2')
  root.style.removeProperty('--uno-3')
  root.style.removeProperty('--uno-4')
  root.style.removeProperty('--uno-5')

  root.style.removeProperty('--duo-1')
  root.style.removeProperty('--duo-2')
  root.style.removeProperty('--duo-3')

  root.style.removeProperty('--accent')
