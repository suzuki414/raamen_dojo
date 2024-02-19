module Public
  class FavoritesController < ApplicationController
    before_action :authenticate_member!

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

  end
end