module Public
  class FavoritesController < ApplicationController
    before_action :authenticate_member!

    def create
      ramen_noodle = RamenNoodle.find(params[:ramen_noodle_id])
      favorite = current_member.favorites.new(ramen_noodle_id: ramen_noodle.id)
      favorite.save
      respond_to do |format|
        format.js { @ramen_noodle = ramen_noodle }
      end
    end

    def destroy
      ramen_noodle = RamenNoodle.find(params[:ramen_noodle_id])
      favorite = current_member.favorites.find_by(ramen_noodle_id: ramen_noodle.id)
      favorite.destroy
      respond_to do |format|
        format.js { @ramen_noodle = ramen_noodle }
      end
    end
  end
end