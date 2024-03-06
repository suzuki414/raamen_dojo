class Admin::RamenNoodleCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @ramen_noodle = RamenNoodle.find(params[:ramen_noodle_id])
    RamenNoodleComment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました。"
  end
end
