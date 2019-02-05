class window.Post extends AppObject
  config:
    className: 'Post'
    api: 'api/posts' # you should confirm this

  
  constructor: (args...) ->
    super(args...)
    @routes =
      show: =>
        "/posts/#{@id}"
      edit: =>
        "/posts/#{@id}/edit"