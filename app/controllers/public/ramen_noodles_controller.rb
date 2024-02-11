module Public
  class RamenNoodlesController < ApplicationController
    before_action :authenticate_member!

    def new
      @ramen_noodle = RamenNoodle.new
    end
    
    def index
      @ramen_noodle = RamenNoodle.all
    end

    def create
      @ramen_noodle = RamenNoodle.new(ramen_noodle_params)
      @ramen_noodle.member_id = current_member.id
      raty_array = [
        @ramen_noodle.taste_rating,
        @ramen_noodle.cook_time_rating,
        @ramen_noodle.process_rating,
        @ramen_noodle.difficulty_rating,
      ]
      @ramen_noodle.average_rating = raty_array.sum.fdiv(raty_array.length)
      if @ramen_noodle.save
        # redirect_to ramen_noodle_path(@ramen_noodle)
        redirect_to root_path
      else
        render :new
      end
    end

    private

    def ramen_noodle_params
      params.require(:ramen_noodle).permit(:post_image, :title, :description, :recipe, :average_rating, :taste_rating, :cook_time_rating, :process_rating, :difficulty_rating, :status)
    end
  end
end