class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  
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

  def edit
    @member = Member.find(params[:id])
  end
  
  def update
    member = Member.find(params[:id])
    member.update(member_params)
    redirect_to admin_member_path(member)
  end
  
  private
  
  def member_params
    params.require(:member).permit(:profile_image, :name, :nickname, :comment, :email, :is_active)
  end
end
