chroma = require 'chroma-js'

root = document.documentElement
uno = ''
duo = ''

module.exports =
  activate: (state) ->

    # Change Preset
    atom.config.observe 'duotone-syntax.preset', (newValue) ->
      root.classList.remove('theme-duotone-syntax--custom-colors')
      switch newValue
        when "Dark Sky"
          uno = '#ff0000'
          duo = '#00ff00'
        when "Dark Sea"
          uno = '#0000ff'
          duo = '#ff0000'
        when "Dark Space"
          uno = '#00ff00'
          duo = '#0000ff'
        when "Dark Forest"
          uno = '#ff0000'
          duo = '#00ff00'
        when "Dark Earth"
          uno = '#0000ff'
          duo = '#ff0000'
        when "Custom"
          root.classList.add('theme-duotone-syntax--custom-colors')
          uno = atom.config.get('duotone-syntax.unoColor').toHexString()
          duo = atom.config.get('duotone-syntax.duoColor').toHexString()
      setColors()

    # Change Uno
    atom.config.onDidChange 'duotone-syntax.unoColor', ({newValue, oldValue}) ->
      uno = newValue.toHexString()
      setColors()

    # Change Duo
    atom.config.onDidChange 'duotone-syntax.duoColor', ({newValue, oldValue}) ->
      duo = newValue.toHexString()
      setColors()

  deactivate: ->
    root.classList.remove('theme-duotone-syntax--custom-colors')
    unsetColors()

# Apply Colors -----------------------
setColors = ->
  unsetColors() # prevents adding endless properties

  # Color limits
  _high = chroma.mix('hsl(0,0%,100%)', uno, 0.5);
  _mid  = uno
  _low  = chroma.mix('hsl(0,0%,25%)', uno, 0.25);

  # Color scales
  _scaleUno = chroma.scale([ _high, _mid, _low]).colors(5)
  _scaleDuo = chroma.scale([ duo, _low]).padding([0, 0.33]).colors(3)

  root.style.setProperty('--uno-1', _scaleUno[0])
  root.style.setProperty('--uno-2', _scaleUno[1])
  root.style.setProperty('--uno-3', _scaleUno[2])
  root.style.setProperty('--uno-4', _scaleUno[3])
  root.style.setProperty('--uno-5', _scaleUno[4])

  root.style.setProperty('--duo-1', _scaleDuo[0])
  root.style.setProperty('--duo-2', _scaleDuo[1])
  root.style.setProperty('--duo-3', _scaleDuo[2])

  root.style.setProperty('--accent', duo)


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
