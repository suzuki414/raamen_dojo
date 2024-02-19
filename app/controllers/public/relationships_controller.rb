module Public
  class RelationshipsController < ApplicationController
    before_action :authenticate_member!, only: [:create, :destroy]

    def create
      member = Member.find(params[:member_id])
      current_member.follow(member)
      redirect_to request.referer
    end

    def destroy
      member = Member.find(params[:member_id])
      current_member.unfollow(member)
      redirect_to  request.referer
    end

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

    private

  end
end