class Api::CommentsController < ApiController

  before_action :verify_permissions
  before_action :set_objects

  # get api/comments
  def index
    comments = Comment.limit(current_limit).offset(current_offset)
    render json: comments.json(requested_scope)
  end

  # get api/comments/:id
  def show
    render json: @comment.json(requested_scope)
  end
  
  # get api/comments/get
  def get
    comments = Comment.get(handle_query_param)
    render json: comments.json(requested_scope)
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

  # get api/comments/search/:query
  def search
    if params[:query].present?
      comments = Comment.search(params[:query]).limit(current_limit).offset(current_offset)
      render json: comments.json(requested_scope)
    end
  end

  # post api/comments
  def create
    @comment.assign_attributes comment_params
    @comment.save
    render json: @comment.json(requested_scope)
  end

  # put/patch api/comments/:id
  def update
    @comment.update comment_params
    render json: @comment.json(requested_scope)
  end

  # delete api/comments/:id
  def destroy
    @comment.destroy
    render json: @comment.json(requested_scope)
  end

  protected

  # --- begin permissions  --- #

  def verify_permissions
    unless requested_scope.in?(allowed_scopes) and CommentSerializer.scope(requested_scope).can_access? action_name
      render json: {error: 'Unauthorized'}, status: :unauthorized
    end
  end

  # --- end permissions  --- #

  def set_objects
    if params[:id].present?
      @comment = Comment.find params[:id]
    else
      @comment = Comment.new
    end
  end

  def comment_params
    if params['pink_obj']
      params["pink_obj"].keep_if {|k,v| CommentSerializer.scope(requested_scope).can_write?(k)}
      params["pink_obj"].permit!
    else
      {}
    end
  end

end
