class ShashinsController < ApplicationController

  def index
    @shashins = Shashin.all.order(updated_at: :desc)
   
  end

  def new
    @shashins = Shashin.new
  end

  def create
    @shashin = Shashin.new(photo_params)
    if @shashin.save
      redirect_to shashins_url
    else
      render  :action => :new
    end
  end  

  def show
    set_photo
  end

  def edit
    set_photo
  end

  def ranking
    #@shashins = Shashin.order(favorites_count: :desc).limit(100)
    now = Time.current 
    @cities = Favorite.where("updated_at BETWEEN ? AND ?", now.beginning_of_month, now.end_of_month) .group(:user_id).order("count(*) desc limit 100" ).count
    @top100_ids = deep_hash_keys(@cities)
    #puts @top100_ids.inspect
    #puts 'top100_ids.inspect'
    #@rank100 = User.where(:id => @top100_ids)
    #@rank100 = User.find(@top100_ids, :order => "field(id, #{@top100_ids.join(',')})")
    @rank100 = User.find(@top100_ids).index_by(&:id).slice(*@top100_ids).values
    #@rank100 = User.order(favorites_count: :desc).limit(100)
    #puts @rank100.inspect
    
  end

  # POST /shashins/:id/favorite
  def favorite
    @shashin = Shashin.find(params[:id])

    @shashin.favorites.create!(user: current_user)
    
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end
  
  # POST /shashins/:id/unfavorite
  def unfavorite
    @shashin = Shashin.find(params[:id])
    
    favorites = Favorite.where(shashin: @shashin, user: current_user)
    favorites.destroy_all
    
    redirect_back(fallback_location: root_path)
  end


  private

  def set_photo
    @shashin = Shashin.find(params[:id])
  end
  
  def photo_params
    params.require(:shashin).permit(:title, :description, :file_location)
  end

  def deep_hash_keys(h)
    h.keys + h.map { |_, v| v.is_a?(Hash) ? deep_hash_keys(v) : nil }.flatten.compact
  end
end
