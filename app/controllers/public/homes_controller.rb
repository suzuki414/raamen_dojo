module Public
  class HomesController < ApplicationController
    
    def top
      @ramen_noodles = RamenNoodle.order(created_at: :desc).limit(5)
      @top_ramen_noodles = RamenNoodle.order('average_rating DESC').limit(5)
    end

  end
end