class PostChannel < PinkmanChannel
  
  # TO DO: use connection/params and return an array of scopes (symbols) the current user can subscribe
  def current_allowed_scopes
    [:public]
  end
  
  # broadcast :public do |config|
  #   config.room :posts
  # end
  
  # --- Quick Broadcast Guide
  
  # Start a broadcast here to transmit Post.
  
  # Who consumes the transmission?
  # Everyone that subscribes to PostChannel and have a current_scope that is broadcasting something.
  
  # What gets broadcasted?
  # Every instance of Post that gets created, updated or destroyed 
  # is broadcasted as json of the passed scope.
  
  # Optionally, you can use filter_by to restrict 
  # the transmission to a particular group of records.
  
  # --- Usage
  
  # -- js/coffe - client:
  #  App.controller 'any-controller', ->
  #    @main = ->
  #      
  #      @subscribe 'PostChannel',
  #        room: 'posts'
  #        filter_by: 123
  
  # -- ruby / server: here (post_channel.rb)
  #  broadcast :public do |config|
  #    config.room :posts
  #    
  #    config.filter_by :attribute
  #    # Only records that got `attribute == 123` will be broadcasted.
  #  
  #  end
  
end