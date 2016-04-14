if Array.isArray  is undefined
  Array.isArray = (obj) ->
    Object.prototype.toString.call(obj) == '[object Array]'
