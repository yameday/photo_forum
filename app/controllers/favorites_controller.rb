class FavoritesController < ApplicationController

   def create
    # 需要設定前端的 link_to，在發出請求時送進 like_id
  @favorite = current_user.favorites.build(like_id: params[:like_id])

    if @favorite.save
      flash[:notice] = "Successfully liked"
      redirect_back(fallback_location: root_path)
    else
      # 驗證失敗時，Model 將錯誤訊息放在 errors 裡回傳
      # 使用 errors.full_messages 取出完成訊息集合(Array)，串接 to_sentence 將 Array 組合成 String
      flash[:alert] = @favorite.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    # where 會回傳物件集合(Array)，需要串接可取出單一物件的方法如 first
    @favorite = current_user.favorites.where(like_id: params[:id]).first
    @favorite.destroy
    flash[:alert] = "like destroyed"
    redirect_back(fallback_location: root_path)
  end
end
