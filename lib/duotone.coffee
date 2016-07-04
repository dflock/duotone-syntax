chroma = require 'chroma-js'
root = document.documentElement

# Colors -----------------------

hue = 240 # must be same as @syntax-hue
preset = 1

uno = 'blue'
unoHue = 240
duo = 'yellow'

saturation = 0
brightness = 0


module.exports =
  activate: (state) ->
    atom.config.observe 'duotone-syntax.preset', (value) ->
      setPreset(value)
      setColors()

    atom.config.observe 'duotone-syntax.unoColor', (value) ->
      setUnoColor(value)
      setColors()

    atom.config.observe 'duotone-syntax.duoColor', (value) ->
      setDuoColor(value)
      setColors()

  deactivate: ->
    unsetColors()



# Set Preset -----------------------
setPreset = (value) ->
  preset = value

# Set Uno Color -----------------------
setUnoColor = (value) ->
  uno = value.toHexString()

# Set Duo Color -----------------------
setDuoColor = (value) ->
  duo  = value.toHexString()



# Set Colors -----------------------
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
