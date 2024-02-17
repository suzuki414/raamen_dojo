# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

  # 最後消す
  # # before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_member!
  # before_action :configure_sign_in_params, only: [:create]
  before_action :member_state, only: [:create]


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def member_state
    if params[:member][:email].blank? || params[:member][:password].blank?
      flash[:notice] = "全ての項目を入力してください。"
      redirect_to new_member_session_path
      return
    end

    member = Member.find_by(email: params[:member][:email])
    unless member
      flash[:notice] = "該当する会員情報が見つかりません。"
      redirect_to new_member_session_path
      return
    end

    return unless member.valid_password?(params[:member][:password])

    if member.is_active
      sign_in(member)
      flash[:notice] = "ログインしました。"
      redirect_to root_path
    else
      flash[:notice] = "退会済みのアカウントです。ご利用の際は再度、新規会員登録が必要になります。"
      redirect_to new_member_registration_path
    end
  end
end
