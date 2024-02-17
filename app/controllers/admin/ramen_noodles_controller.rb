class Admin::RamenNoodlesController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:latest]
      @ramen_noodles = RamenNoodle.latest.page(params[:page]).per(10)
    elsif params[:old]
      @ramen_noodles = RamenNoodle.old.page(params[:page]).per(10)
    elsif params[:average_rating_count]
      @ramen_noodles = RamenNoodle.average_rating_count.page(params[:page]).per(10)
    elsif params[:favorite_count]
      @ramen_noodles = RamenNoodle.order_by_favorite_count.page(params[:page]).per(10)
    else
      @ramen_noodles = RamenNoodle.latest.page(params[:page]).per(10)
    end
  end

  def show
    @ramen_noodle = RamenNoodle.find(params[:id])
    @tag_list = @ramen_noodle.tags.pluck(:name).join(',')
    @ramen_noodle_tags = @ramen_noodle.tags
    @ramen_noodle_comment = RamenNoodleComment.new
  end

  def edit
    @ramen_noodle = RamenNoodle.find(params[:id])
    @tag_list = @ramen_noodle.tags.pluck(:name).join(',')
  end

  def update
    @ramen_noodle = RamenNoodle.find(params[:id])
    tag_list = params[:ramen_noodle][:name].split(',')
    if @ramen_noodle.update(ramen_noodle_params)
      @ramen_noodle.save_tags(tag_list)
      flash[:notice] = "編集内容を反映させました。"
      redirect_to ramen_noodle_path(@ramen_noodle)
    else
      render :edit
    end
  end
end
