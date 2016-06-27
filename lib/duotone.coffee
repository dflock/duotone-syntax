chroma = require 'chroma-js'
root = document.documentElement

# Colors -----------------------

hue = 240 # must be same as @syntax-hue

contrast = 6
accent = 'yellow'


module.exports =
  activate: (state) ->
    atom.config.observe 'duotone-syntax.contrast', (value) ->
      setContrast(value)
      setColors()

    atom.config.observe 'duotone-syntax.accentColor', (value) ->
      setAccent(value)
      setColors()

  deactivate: ->
    unsetColors()


# Set Contrast -----------------------
setContrast = (value) ->
  contrast = value / 12


# Set Accent -----------------------
setAccent = (value) ->
  accent  = value.toHexString()

# Set Colors -----------------------
setColors = ->
  unsetColors() # prevents adding endless properties

  # Contrast
  _high = chroma('hsl(240,99%,88%)').brighten(contrast).saturate(contrast)
  _mid  = chroma('hsl(240,28%,66%)').brighten(contrast).saturate(contrast)
  _low  = chroma('hsl(240,11%,36%)').brighten(contrast)
  _accent = chroma(accent).brighten(contrast).saturate(contrast)

  # Color scale accent with bg
  _scaleUno = chroma.scale([ _high, _mid, _low]).colors(5)
  _scaleDuo = chroma.scale([ _accent, _low]).padding([0, 0.25]).colors(3)

  root.style.setProperty('--uno-1', _scaleUno[0])
  root.style.setProperty('--uno-2', _scaleUno[1])
  root.style.setProperty('--uno-3', _scaleUno[2])
  root.style.setProperty('--uno-4', _scaleUno[3])
  root.style.setProperty('--uno-5', _scaleUno[4])

  root.style.setProperty('--duo-1', _scaleDuo[0])
  root.style.setProperty('--duo-2', _scaleDuo[1])
  root.style.setProperty('--duo-3', _scaleDuo[2])

  root.style.setProperty('--accent', accent)

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
