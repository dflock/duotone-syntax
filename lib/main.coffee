root = document.documentElement

module.exports =
  activate: (state) ->
    atom.config.observe 'duotone-syntax.accentColor', (value) ->
      setAccentColor(value)

  deactivate: ->
    unsetAccentColor()


# Accent Color -----------------------
setAccentColor = (accentColor) ->
  root.style.removeProperty('--duo-1') # prevents adding endless properties
  root.style.setProperty('--duo-1', accentColor.toHexString())

unsetAccentColor = ->
  root.style.removeProperty('--duo-1')
