module Public
  class RelationshipsController < ApplicationController
    before_action :authenticate_member!, only: [:create, :destroy]
    before_action :ensure_guest_member, only: [:create, :destroy]

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
      if params[:mypage_ramen_noodle]
        @member = current_member.followings
      elsif params[:member_ramen_noodle]
        member = Member.find(params[:member_id])
        @member = member.followings
      else
        if params[:follower]
          @member = member.follower
        else
          @member = member.followings
        end
      end
      @member = @member.page(params[:page]).per(12)
    end

    # def followings
    #   member = Member.find(params[:member_id])
    #   @members = member.followings
    # end

    # def followers
    #   member = Member.find(params[:member_id])
    #   @members = member.followers
    # end
    
    private
    
    def ensure_guest_member
      @member = Member.find(params[:id])
      if @member.guest_member?
        redirect_to request.referer, notice: "フォローをするには、会員登録が必要です"
      end
    end
  end
end