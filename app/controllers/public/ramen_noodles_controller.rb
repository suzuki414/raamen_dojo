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
      if @ramen_noodle.save
        redirect_to ramen_noodle_path(@ramen_noodle)
      else
        render :new
      end
    end

    private

    def ramen_noodle_params
      params.require(:RamenNoodle).permit(:title, :description, :recipe, :average_rating, :taste_rating, :cook_time_rating, :process_rating, :difficulty_rating, :status)
    end
  end
end