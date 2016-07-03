chroma = require 'chroma-js'
root = document.documentElement

# Colors -----------------------

hue = 240 # must be same as @syntax-hue

uno = 'blue'
unoHue = 240
duo = 'yellow'
contrast = 3


module.exports =
  activate: (state) ->
    atom.config.observe 'duotone-syntax.unoColor', (value) ->
      setUnoColor(value)
      setColors()

    atom.config.observe 'duotone-syntax.duoColor', (value) ->
      setDuoColor(value)
      setColors()

    atom.config.observe 'duotone-syntax.contrast', (value) ->
      setContrast(value)
      setColors()


  deactivate: ->
    unsetColors()


# Set Uno Color -----------------------
setUnoColor = (value) ->
  _uno = value.toHexString()
  uno = _uno
  unoHue  = chroma(_uno).get('hsl.h')

# Set Duo Color -----------------------
setDuoColor = (value) ->
  duo  = value.toHexString()

# Set Contrast -----------------------
setContrast = (value) ->
  contrast = value / 8


# Set Colors -----------------------
setColors = ->
  unsetColors() # prevents adding endless properties

  # Contrast
  _high = chroma.hsl(unoHue,.99,.88).brighten(contrast).saturate(contrast)
  _mid  = uno
  _low  = chroma.hsl(unoHue,.11,.24).brighten(contrast)
  _duo  = chroma(duo).brighten(contrast).saturate(contrast)

  # Color scale accent with bg
  _scaleUno = chroma.scale([ _high, _mid, _low]).colors(5)
  _scaleDuo = chroma.scale([ _duo, _low]).padding([0, 0.25]).colors(3)

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
