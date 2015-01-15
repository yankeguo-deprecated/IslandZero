window.isBlank = (str) ->
  (!str || /^\s*$/.test(str))
