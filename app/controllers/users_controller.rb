class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def ranking
    @users = User.order(favorites_count: :desc).limit(10)
  end

  # POST /users/:id/favorite
  def favorite
    @user = User.find(params[:id])
puts @user.id.to_s
puts current_user.id.to_s

    @user.favorites.create!(user: current_user, like_id: @user.id)
    
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end
  
  # POST /users/:id/unfavorite
  def unfavorite
    @user = User.find(params[:id])
    
    favorites = Favorite.where(user: @user, user: current_user)
    favorites.destroy_all
    
    redirect_back(fallback_location: root_path)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

end
