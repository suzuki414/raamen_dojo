module Public
  class RamenNoodlesController < ApplicationController
    before_action :authenticate_member!, only: [:new, :edit, :create, :update]
    skip_before_action :verify_authenticity_token, only: [:get_tag]

    def new
      @ramen_noodle = RamenNoodle.new
    end

    def get_tag
      @tags = Vision.get_image_data(params[:uploadfile])
      @tags_ja = Translation.translate_words(@tags)
      render json: { tags: @tags_ja }
    end

    def show
      @ramen_noodle = RamenNoodle.find(params[:id])
      @tag_list = @ramen_noodle.tags.pluck(:name).join(',')
      @ramen_noodle_tags = @ramen_noodle.tags
      @ramen_noodle_comment = RamenNoodleComment.new
    end

    def index
      @permitted_params = [:mypage_ramen_noodle, :member_ramen_noodle, :mypage_ramen_noodle_favorite, :member_ramen_noodle_favorite, :member_id]
      # パラメーターに応じた、投稿ページを表示
      if params[:mypage_ramen_noodle]
        @ramen_noodles = current_member.ramen_noodles
      elsif params[:member_ramen_noodle]
        @member = Member.find(params[:member_id])
        @ramen_noodles = @member.ramen_noodles
      else
        # パラメーターに応じた、いいねした投稿ページを表示
        if params[:mypage_ramen_noodle_favorite]
          @ramen_noodles = current_member.favorite_ramen_noodles
        elsif params[:member_ramen_noodle_favorite]
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

    def create
      @ramen_noodle = RamenNoodle.new(ramen_noodle_params)
      @ramen_noodle.member_id = current_member.id
      tag_list = params[:ramen_noodle][:name].split(',').uniq
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
      unless current_member == @ramen_noodle.member
        flash[:alert] = "他会員の投稿は編集出来ません。"
        redirect_back(fallback_location: ramen_noodles_path)
        return
      end
      @tag_list = @ramen_noodle.tags.pluck(:name).join(',')
    end

    def update
      @ramen_noodle = RamenNoodle.find(params[:id])
      tag_list = params[:ramen_noodle][:name].split(',').uniq
      if @ramen_noodle.update(ramen_noodle_params)
        @ramen_noodle.save_tags(tag_list)
        flash[:notice] = "編集内容を反映させました。"
        redirect_to ramen_noodle_path(@ramen_noodle)
      else
        render :edit
      end
    end

    def destroy
      ramen_noodle = RamenNoodle.find(params[:id])
      ramen_noodle.destroy
      redirect_to ramen_noodles_path(mypage_ramen_noodle: "true")
    end

    private

    def ramen_noodle_params
      params.require(:ramen_noodle).permit(:post_image, :title, :description, :recipe, :average_rating, :taste_rating, :cook_time_rating, :process_rating, :difficulty_rating, :status)
    end

  end
end