module Public
  class MembersController < ApplicationController
    before_action :authenticate_member!, only: [:my_page, :edit, :update, :withdraw, :complete, :unsubscribe]
    before_action :ensure_guest_member, only: [:edit, :update, :withdraw, :complete, :unsubscribe]

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

    def update
      @member = current_member
      if @member.update(member_params)
        flash[:success] = "会員情報を変更しました。"
        redirect_to my_page_path
      else
        render 'edit'
      end
    end

    def withdraw
      @member = Member.find(current_member.id)
      @member.update(is_active: false)
      reset_session
      flash[:notice] = "退会しました。"
      redirect_to root_path
    end

    private

    def member_params
      params.require(:member).permit(:profile_image, :name, :nickname, :comment, :is_active)
    end

    def ensure_guest_member
      @member = Member.find(params[:id])
      if @member.guest_member?
        redirect_to request.referer, notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end

  end
end