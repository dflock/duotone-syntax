chroma = require 'chroma-js'
root = document.documentElement

# Colors -----------------------

hue = 240 # must be same as @syntax-hue

high = 'hsl(240,99%,99%)'
mid  = 'hsl(240,44%,66%)'
low  = 'hsl(240,10%,44%)'

module.exports =
  activate: (state) ->
    atom.config.observe 'duotone-syntax.accentColor', (value) ->
      setColors(value)

  deactivate: ->
    unsetColors()


# Set Colors -----------------------
setColors = (accentColor) ->
  unsetColors() # prevents adding endless properties

  # get new accent color
  _duo  = accentColor.toHexString()

  # Color scale accent with bg
  _scaleUno = chroma.scale([high, mid, low]).colors(5)
  _scaleDuo = chroma.scale([     _duo, low]).colors(4)

  root.style.setProperty('--uno-1', _scaleUno[0])
  root.style.setProperty('--uno-2', _scaleUno[1])
  root.style.setProperty('--uno-3', _scaleUno[2])
  root.style.setProperty('--uno-4', _scaleUno[3])
  root.style.setProperty('--uno-5', _scaleUno[4])

  root.style.setProperty('--duo-1', _scaleDuo[0])
  root.style.setProperty('--duo-2', _scaleDuo[1])
  root.style.setProperty('--duo-3', _scaleDuo[2])

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
