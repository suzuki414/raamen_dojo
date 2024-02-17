class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @members = Member.page(params[:page]).per(12)
  end

  def show
     @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end
end
