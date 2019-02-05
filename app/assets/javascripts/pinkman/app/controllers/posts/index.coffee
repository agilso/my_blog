App.controller 'posts-index', ->
  
  @main = ->
    posts = new Posts
    posts.fetch (posts) ->
      posts.render('posts-index')
      
      
  @action 'destroy-post', 'click', (post) ->
    post.destroy()
    $r.reload()