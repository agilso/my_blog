App.controller 'posts-show', ->
  
  @bind ['username', 'msg']
  
  @main = ->
    Posts.one
      scope: 'public'
      query: @params.id
      cache: no
      callback: (post) =>
        window.post = post
        post.comments.new()
        post.render('posts-show')
        
        
        @subscribe 'CommentChannel',
          room: 'comments'
          scope: 'public'
          filter_by: @params.id
          callback: (incoming) ->
            switch incoming.action
              when 'create'
                comment = new Comment
                comment.assign incoming.data       
                post.comments.unshift(comment)
                post.render()
              when 'update'
                console.log 'atualizou comentário'
              when 'destroy'
                console.log 'apagou comentário'
          
  
  @action 'new-comment', 'submit', (comment) ->
    comment.set('post_id', post.id)
    comment.save (comment) ->
      unless comment.hasErrors()
        post.comments.unshift(comment)
        post.new_comment = new Comment
      post.render()
    
    