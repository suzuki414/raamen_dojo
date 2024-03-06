class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!

  def follow
    @member = Member.find(params[:member_id])
    if params[:mypage_followings]
      @members = current_member.followings
    elsif params[:member_followings]
      @members = @member.followings
    else
      if params[:follower]
        @members = @member.followers
      else
        @members = @member.followings
      end
    end
    @members = @members.page(params[:page]).per(12)
  end
end
