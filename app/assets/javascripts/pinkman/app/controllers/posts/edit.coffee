App.controller 'posts-edit', ->
  
  @bind ['title', 'body']
  
  @main = ->
    Posts.one
      scope: 'public'
      query: @params.id
      cache: no
      callback: (post) ->
        post.render('posts-edit')
    
  
  @action 'post-form', 'submit', (post) ->
    post.save (post) ->
      if post.hasErrors()
        post.render()
      else
        $r.go '/'