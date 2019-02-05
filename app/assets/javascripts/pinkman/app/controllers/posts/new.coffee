App.controller 'posts-new', ->
  
  @bind ['title', 'body']
  
  @main = ->
    post = new Post
    post.render('posts-new')
    
  
  @action 'post-form', 'submit', (post) ->
    post.save (post) ->
      if post.hasErrors()
        post.render()
      else
        $r.go '/'