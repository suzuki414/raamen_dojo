module Public
  class RamenNoodleCommentsController < ApplicationController
    before_action :authenticate_member!
    before_action :ensure_guest_member

    def create
      ramen_noodle = RamenNoodle.find(params[:ramen_noodle_id])
      comment = current_member.ramen_noodle_comments.new(ramen_noodle_comment_params)
      comment.ramen_noodle_id = ramen_noodle.id
      comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to ramen_noodle_path(ramen_noodle)
    end

    def destroy
      RamenNoodleComment.find(params[:id]).destroy
      flash[:notice] = "コメントを削除しました。"
      redirect_to ramen_noodle_path(params[:ramen_noodle_id])
    end

    private

    def ramen_noodle_comment_params
      params.require(:ramen_noodle_comment).permit(:comment)
    end
    
    def ensure_guest_member
      @member = Member.find(params[:id])
      if @member.guest_member?
        redirect_to request.referer, notice: "コメントをするには、会員登録が必要です"
      end
    end

  end
end