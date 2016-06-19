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

  _mono = 'hsl(240,22%,66%)'
  _uno  = 'hsl(240,99%,78%)'
  _duo  = accentColor.toHexString()

  # Scale accent with bg
  _scaleMono = chroma.scale([fg, _mono, bg]).colors(4)
  _scaleUno = chroma.scale([_uno, bg]).colors(4)
  _scaleDuo = chroma.scale([_duo, bg]).colors(4)

  root.style.setProperty('--mono-1', _scaleMono[0])
  root.style.setProperty('--mono-2', _scaleMono[1])
  root.style.setProperty('--mono-3', _scaleMono[2])
  root.style.setProperty('--mono-4', _scaleMono[3])

  root.style.setProperty('--uno-1', _scaleUno[0])
  root.style.setProperty('--uno-2', _scaleUno[1])
  root.style.setProperty('--uno-3', _scaleUno[2])

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
