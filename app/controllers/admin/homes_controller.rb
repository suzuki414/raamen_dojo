class Admin::HomesController < ApplicationController
  def top
    # ソート機能
    if params[:old]
      @ramen_noodles = @ramen_noodles.old
    elsif params[:average_rating_count]
      @ramen_noodles = @ramen_noodles.average_rating_count
    elsif params[:favorite_count]
      @ramen_noodles = @ramen_noodles.order_by_favorite_count_and_latest
    else
      @ramen_noodles = @ramen_noodles.latest
    end
    @ramen_noodles = @ramen_noodles.page(params[:page]).per(10)
  end
end
