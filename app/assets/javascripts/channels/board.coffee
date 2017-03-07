App.board = App.cable.subscriptions.create "BoardChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    data = data.data
    if data.message == "true"
      m = confirm('Are you sure you want to clear ?')
      if m
        window.ctx.clearRect 0, 0, data.w, data.h
        $("#canvasimg")[0].style.display = 'none'
    else
      window.ctx.beginPath()
      window.ctx.moveTo data.prevX, data.prevY
      window.ctx.lineTo data.currX, data.currY
      window.ctx.strokeStyle = data.strokeStyle
      window.ctx.lineWidth = data.lineWidth
      window.ctx.stroke()
      window.ctx.closePath()

  draw: (data) ->
    @perform 'draw', data: data

  clear: (data) ->
    @perform 'clear', data: data

