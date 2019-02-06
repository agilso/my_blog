class CommentChannel < PinkmanChannel
  
  # TO DO: use connection/params and return an array of scopes (symbols) the current user can subscribe
  def current_allowed_scopes
    [:public]
  end
  
  broadcast :public do |config|
    config.room :comments
    config.filter_by :post_id
  end
  
  # --- Quick Broadcast Guide
  
  # Start a broadcast here to transmit Comment.
  
  # Who consumes the transmission?
  # Everyone that subscribes to CommentChannel and have a current_scope that is broadcasting something.
  
  # What gets broadcasted?
  # Every instance of Comment that gets created, updated or destroyed 
  # is broadcasted as json of the passed scope.
  
  # Optionally, you can use filter_by to restrict 
  # the transmission to a particular group of records.
  
  # --- Usage
  
  # -- js/coffe - client:
  #  App.controller 'any-controller', ->
  #    @main = ->
  #      
  #      @subscribe 'CommentChannel',
  #        room: 'comments'
  #        filter_by: 123
  
  # -- ruby / server: here (comment_channel.rb)
  #  broadcast :public do |config|
  #    config.room :comments
  #    
  #    config.filter_by :attribute
  #    # Only records that got `attribute == 123` will be broadcasted.
  #  
  #  end
  
end