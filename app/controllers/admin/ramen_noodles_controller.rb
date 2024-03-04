class Admin::RamenNoodlesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @permitted_params = [:member_ramen_noodle, :member_ramen_noodle_favorite, :member_id]
    # パラメーターに応じた、投稿ページを表示
    if params[:member_ramen_noodle]
      @member = Member.find(params[:member_id])
      @ramen_noodles = @member.ramen_noodles
    else
      # パラメーターに応じた、いいねした投稿ページを表示
      if params[:member_ramen_noodle_favorite]
        @member = Member.find(params[:member_id])
        @ramen_noodles = @member.favorite_ramen_noodles
      else
        @ramen_noodles = RamenNoodle.all
        @ramen_noodles = @ramen_noodles.where.not(member_id: current_member.id) if current_member
      end
    end
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
    tag_list = params[:ramen_noodle][:name].split(',').uniq
    if @ramen_noodle.update(ramen_noodle_params)
      @ramen_noodle.save_tags(tag_list)
      flash[:notice] = "編集内容を反映させました。"
      redirect_to admin_ramen_noodle_path(@ramen_noodle)
    else
      render :edit
    end
  end
  
  def destroy
    ramen_noodle = RamenNoodle.find(params[:id])
    ramen_noodle.destroy
    redirect_to admin_ramen_noodles_path
  end
  
  private

  def ramen_noodle_params
    params.require(:ramen_noodle).permit(:post_image, :title, :description, :recipe, :average_rating, :taste_rating, :cook_time_rating, :process_rating, :difficulty_rating, :status)
  end
end
