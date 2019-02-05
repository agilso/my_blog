App.controller 'posts-show', ->
  
  @main = ->
    Posts.one
      scope: 'public'
      query: @params.id
      cache: no
      callback: (post) ->
        post.render('posts-show')