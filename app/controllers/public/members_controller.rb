module Public
  class MembersController < ApplicationController
    before_action :authenticate_member!, only: [:my_page, :edit, :withdraw, :complete, :unsubscribe]
    before_action :ensure_guest_member, only: [:edit, :withdraw, :complete, :unsubscribe]

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

    def withdraw
      @member = Member.find(current_member.id)
      @member.update(is_active: false)
      reset_session
      flash[:notice] = "退会しました。"
      redirect_to account_closed_path
    end

    private

    def ensure_guest_member
      @member = Member.find(current_member.id)
      if @member.guest_member?
        redirect_to request.referer, notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end

  end
end