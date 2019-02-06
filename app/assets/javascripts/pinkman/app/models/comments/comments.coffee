class window.Comments extends AppCollection
  config:
    api: 'api/comments' # you should confirm this
    className: 'Comments'
    memberClass: ->
      return (new Comment)
