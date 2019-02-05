class window.Posts extends AppCollection
  config:
    api: 'api/posts' # you should confirm this
    className: 'Posts'
    memberClass: ->
      return (new Post)
