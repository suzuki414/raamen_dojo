module Public
  class RamenNoodlesController < ApplicationController
    before_action :authenticate_member!, only: [:new, :edit, :create, :update]

    def new
      @ramen_noodle = RamenNoodle.new
    end

    def show
      @ramen_noodle = RamenNoodle.find(params[:id])
      @tag_list = @ramen_noodle.tags.pluck(:name).join(',')
      @ramen_noodle_tags = @ramen_noodle.tags
      @ramen_noodle_comment = RamenNoodleComment.new
    end

    def index
      if params[:mypage_ramen_noddle]
        @member = Member.find(params[:id])
        @ramen_noddles = @member.ramen_nobbles_id
      else
        if params[:old]
          @ramen_noodles = RamenNoodle.old.page(params[:page]).per(10)
        elsif params[:average_rating_count]
          @ramen_noodles = RamenNoodle.average_rating_count.page(params[:page]).per(10)
        elsif params[:favorite_count]
          @ramen_noodles = RamenNoodle.order_by_favorite_count.page(params[:page]).per(10)
        else
          @ramen_noodles = RamenNoodle.latest.page(params[:page]).per(10)
        end
      end  
    end

    def create
      @ramen_noodle = RamenNoodle.new(ramen_noodle_params)
      @ramen_noodle.member_id = current_member.id
      tag_list = params[:ramen_noodle][:name].split(',')
      raty_array = [
        (@ramen_noodle.taste_rating)? @ramen_noodle.taste_rating : 1,
        (@ramen_noodle.cook_time_rating)? @ramen_noodle.cook_time_rating : 1,
        (@ramen_noodle.process_rating)? @ramen_noodle.process_rating : 1,
        (@ramen_noodle.difficulty_rating)? @ramen_noodle.difficulty_rating : 1,
      ]
      @ramen_noodle.average_rating = raty_array.sum.fdiv(raty_array.length)
      if @ramen_noodle.save
        @ramen_noodle.save_tags(tag_list)
        flash[:notice] = "投稿しました。"
        redirect_to ramen_noodle_path(@ramen_noodle)
      else
        render :new
      end
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

    private

    def ramen_noodle_params
      params.require(:ramen_noodle).permit(:post_image, :title, :description, :recipe, :average_rating, :taste_rating, :cook_time_rating, :process_rating, :difficulty_rating, :status)
    end
  end
end