class window.Post extends AppObject
  config:
    className: 'Post'
    api: 'api/posts' # you should confirm this

  
  constructor: (args...) ->
    super(args...)
    
    # Similar ao ruby de:
    # has_many :comments
    @comments = new Comments
    @new_comment = new Comment
    
    @routes =
      show: =>
        "/posts/#{@id}"
      edit: =>
        "/posts/#{@id}/edit"