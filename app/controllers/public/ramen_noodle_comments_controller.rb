module Public
  class RamenNoodleCommentsController < ApplicationController
    before_action :authenticate_member!

    def create
      ramen_noodle = RamenNoodle.find(params[:ramen_noodle_id])
      comment = current_member.ramen_noodle_comments.new(ramen_noodle_comment_params)
      comment.ramen_noodle_id = ramen_noodle.id
      comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to ramen_noodle_path(ramen_noodle)
    end

    private

    def ramen_noodle_comment_params
      params.require(:ramen_noodle_comment).permit(:comment)
    end

  end
end