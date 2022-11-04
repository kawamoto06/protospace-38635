class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_user, only: [:edit]



  def index
    @prototypes = Prototype.all
    
  end

  def new
    @prototype = Prototype.new
    
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
    
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept ).merge(user_id: current_user.id,)
  end
  private
  def ensure_user
    @prototypes = current_user.prototypes
    @prototype = @prototypes.find_by(id: params[:id])
    redirect_to root_path unless @prototype
  end
  

end
