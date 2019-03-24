class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @favorited_shashins = @user.favorited_shashins
    @shashin = Shashin.where(user_id: params[:id]).last
    @shashins = Shashin.where(user_id: params[:id])
    #@shashin= Shashin.find_by(user_id: params[:id])
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    
    if user_params[:avatar]
      
      #puts user_params[:avatar][:filename]
      @user.update(user_params)
      #@shashin.create(title: user_params[:name],description: user_params[:intro],file_location: user_params[:avatar], user: current_user)
      shashin = Shashin.new(
        title: user_params[:name],
        description: user_params[:intro],
        file_location:  @user.avatar,
        user_id: @user.id
      )
     
      shashin.save!
    
    end
    
    @user.update(user_params)
    redirect_to user_path(@user)
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

end
