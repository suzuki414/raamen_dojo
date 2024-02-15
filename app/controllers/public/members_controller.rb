module Public
  class MembersController < ApplicationController
    before_action :authenticate_member!, only: [:my_page, :edit, :update]
    before_action :ensure_guest_member, only: [:show, :edit]

    def index
      @members = Member.page(params[:page]).per(12)
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
    end

    def withdraw
      @member = Member.find(current_member.id)
      @member.update(is_active: false)
      reset_session
      flash[:notice] = "退会しました。"
      redirect_to root_path
    end

    private

    def ensure_guest_member
      @member = Member.find(params[:id])
      if @member.guest_member?
        redirect_to my_page_path, notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end

  end
end