module Public
  class FavoritesController < ApplicationController
    before_action :authenticate_member!
    before_action :ensure_guest_member

    def create
      ramen_noodle = RamenNoodle.find(params[:ramen_noodle_id])
      favorite = current_member.favorites.new(ramen_noodle_id: ramen_noodle.id)
      favorite.save
      redirect_to ramen_noodle_path(ramen_noodle)
    end

    def destroy
      ramen_noodle = RamenNoodle.find(params[:ramen_noodle_id])
      favorite = current_member.favorites.find_by(ramen_noodle_id: ramen_noodle.id)
      favorite.destroy
      redirect_to ramen_noodle_path(ramen_noodle)
    end
    
    private
    
    def ensure_guest_user
      @member = Member.find(params[:id])
      if @member.email == "guest@example.com"
        redirect_to request.referer , notice: "いいねをするには、会員登録が必要です。"
      end
    end

  end
end