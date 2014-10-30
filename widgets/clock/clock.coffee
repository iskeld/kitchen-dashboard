class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    h = today.getHours()
    m = today.getMinutes()
    s = today.getSeconds()
    m = @formatTime(m)
    s = @formatTime(s)
    
    d = today.getDate()
    mo = today.getMonth() + 1 
    y = today.getFullYear()

    @set('time', h + ":" + m + ":" + s)
    @set('date', d  + "-" + mo + "-" + y)

  formatTime: (i) ->
    if i < 10 then "0" + i else i