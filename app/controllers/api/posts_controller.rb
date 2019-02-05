class Api::PostsController < ApiController

  before_action :verify_permissions
  before_action :set_objects

  # get api/posts
  def index
    posts = Post.all.order("created_at DESC")
    render json: posts.json(requested_scope)
  end

  # get api/posts/:id
  def show
    render json: @post.json(requested_scope)
  end
  
  # get api/posts/get
  def get
    posts = Post.get(handle_query_param)
    render json: posts.json(requested_scope)
  end
  
  # --- TO DO: Revise this ---
  def handle_query_param
    if params[:query].is_a? ActionController::Parameters 
      params[:query].permit!
      params[:query].to_h
    else
      params[:query]
    end
  end

  # get api/posts/search/:query
  def search
    if params[:query].present?
      posts = Post.search(params[:query]).limit(current_limit).offset(current_offset)
      render json: posts.json(requested_scope)
    end
  end

  # post api/posts
  def create
    @post.assign_attributes post_params
    @post.save
    render json: @post.json(requested_scope)
  end

  # put/patch api/posts/:id
  def update
    @post.update post_params
    render json: @post.json(requested_scope)
  end

  # delete api/posts/:id
  def destroy
    @post.destroy
    render json: @post.json(requested_scope)
  end

  protected

  # --- begin permissions  --- #

  def verify_permissions
    unless requested_scope.in?(allowed_scopes) and PostSerializer.scope(requested_scope).can_access? action_name
      render json: {error: 'Unauthorized'}, status: :unauthorized
    end
  end

  # --- end permissions  --- #

  def set_objects
    if params[:id].present?
      @post = Post.find params[:id]
    else
      @post = Post.new
    end
  end

  def post_params
    if params['pink_obj']
      params["pink_obj"].keep_if {|k,v| PostSerializer.scope(requested_scope).can_write?(k)}
      params["pink_obj"].permit!
    else
      {}
    end
  end

end
