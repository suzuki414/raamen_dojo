class Members::SessionsController < Devise::SessionsController
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to my_page_path, notice: "ゲスト会員でログインしました。"
  end
end
