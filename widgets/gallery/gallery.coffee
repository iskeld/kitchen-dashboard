class Dashing.Gallery extends Dashing.Widget
 
  ready: ->
    # This is fired when the widget is done being rendered
 
  onData: (data) ->
    $(@node).fadeOut(1000, () => 
      @set('containerStyle', "background-image: url(#{data.imageUrl})")
      $(@node).fadeIn(1000))

    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in. 
