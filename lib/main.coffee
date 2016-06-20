chroma = require 'chroma-js'
root = document.documentElement

fg = 'hsl(240,99%,99%)'
bg = 'hsl(240,10%,44%)'

module.exports =
  activate: (state) ->
    atom.config.observe 'duotone-syntax.accentColor', (value) ->
      setAccentColor(value)

  deactivate: ->
    unsetAccentColor()


# Accent Color -----------------------
setAccentColor = (accentColor) ->
  unsetAccentColor() # prevents adding endless properties

  _uno  = 'hsl(240,44%,66%)'
  _duo  = accentColor.toHexString()

  # Scale accent with bg
  _scaleUno = chroma.scale([fg, _uno, bg]).colors(5)
  _scaleDuo = chroma.scale([_duo, bg]).colors(4)

  root.style.setProperty('--uno-1', _scaleUno[0])
  root.style.setProperty('--uno-2', _scaleUno[1])
  root.style.setProperty('--uno-3', _scaleUno[2])
  root.style.setProperty('--uno-4', _scaleUno[3])
  root.style.setProperty('--uno-5', _scaleUno[4])

  root.style.setProperty('--duo-1', _scaleDuo[0])
  root.style.setProperty('--duo-2', _scaleDuo[1])
  root.style.setProperty('--duo-3', _scaleDuo[2])


unsetAccentColor = ->
  root.style.removeProperty('--mono-1')
  root.style.removeProperty('--mono-2')
  root.style.removeProperty('--mono-3')
  root.style.removeProperty('--mono-4')

  root.style.removeProperty('--uno-1')
  root.style.removeProperty('--uno-2')
  root.style.removeProperty('--uno-3')

  root.style.removeProperty('--duo-1')
  root.style.removeProperty('--duo-2')
  root.style.removeProperty('--duo-3')
