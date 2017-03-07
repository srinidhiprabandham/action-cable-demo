$(document).ready ->
  canvas = undefined
  ctx = undefined
  w = undefined
  h = undefined
  flag = false
  prevX = 0
  currX = 0
  prevY = 0
  currY = 0
  dot_flag = false
  x = 'black'
  y = 2

  $("#green").on 'click', -> color(this)
  $("#blue").on 'click', -> color(this)
  $("#red").on 'click', -> color(this)
  $("#yellow").on 'click', -> color(this)
  $("#orange").on 'click', -> color(this)
  $("#black").on 'click', -> color(this)
  $("#white").on 'click', -> color(this)

  $("#clr").on 'click', -> 
    erase()

  init = ->
    canvas = $("#board")[0]
    ctx = canvas.getContext('2d')
    w = canvas.width
    h = canvas.height
    canvas.addEventListener 'mousemove', ((e) ->
      # TODO implement websockets here and add drawing
      # to all subscribers
      findxy 'move', e
      return
    ), false
    canvas.addEventListener 'mousedown', ((e) ->
      findxy 'down', e
      return
    ), false
    canvas.addEventListener 'mouseup', ((e) ->
      findxy 'up', e
      return
    ), false
    canvas.addEventListener 'mouseout', ((e) ->
      findxy 'out', e
      return
    ), false
    return

  color = (obj) ->
    switch obj.id
      when 'green'
        x = 'green'
      when 'blue'
        x = 'blue'
      when 'red'
        x = 'red'
      when 'yellow'
        x = 'yellow'
      when 'orange'
        x = 'orange'
      when 'black'
        x = 'black'
      when 'white'
        x = 'white'
    if x == 'white'
      y = 14
    else
      y = 2
    return

  draw = ->
    ctx.beginPath()
    ctx.moveTo prevX, prevY
    ctx.lineTo currX, currY
    ctx.strokeStyle = x
    ctx.lineWidth = y
    ctx.stroke()
    ctx.closePath()
    return

  erase = ->
    m = confirm('Want to clear')
    if m
      ctx.clearRect 0, 0, w, h
      $("#canvasimg")[0].style.display = 'none'
    return

  findxy = (res, e) ->
    if res == 'down'
      prevX = currX
      prevY = currY
      currX = e.clientX - (canvas.offsetLeft)
      currY = e.clientY - (canvas.offsetTop)
      flag = true
      dot_flag = true
      if dot_flag
        ctx.beginPath()
        ctx.fillStyle = x
        ctx.fillRect currX, currY, 2, 2
        ctx.closePath()
        dot_flag = false
    if res == 'up' or res == 'out'
      flag = false
    if res == 'move'
      if flag
        prevX = currX
        prevY = currY
        currX = e.clientX - (canvas.offsetLeft)
        currY = e.clientY - (canvas.offsetTop)
        draw()

  #Initialize the board
  init()
