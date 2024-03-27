module Public
  class MembersController < ApplicationController
    before_action :authenticate_member!, only: [:my_page, :edit, :withdraw, :complete, :unsubscribe]
    before_action :ensure_guest_member, only: [:withdraw]

    def index
      if params[:old]
        @members = Member.old.page(params[:page]).per(12)
      elsif params[:followed_count]
        @members = Member.order_by_followed_count.page(params[:page]).per(12)
      elsif params[:ramen_noodle_count]
        @members = Member.order_by_ramen_noodle_count.page(params[:page]).per(12)
      else
        @members = Member.latest.page(params[:page]).per(12)
      end
    end

    def show
      @member = Member.find(params[:id])
    end

    def my_page
      @member = current_member
    end

    def edit
      @member = current_member
    end

    def unsubscribe
      @member = current_member
    end

    def withdraw
      @member = Member.find(current_member.id)
      @member.update(is_active: false)
      reset_session
      flash[:notice] = "退会しました。"
      redirect_to account_closed_members_path
    end

    private

    def ensure_guest_member
      @member = Member.find(current_member.id)
      if @member.guest_member?
        redirect_to request.referer, notice: "ゲスト会員は、会員情報の編集内容保存および退会処理ができません。"
      end
    end

  end
end