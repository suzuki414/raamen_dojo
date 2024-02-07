module Member
  class MembersController < ApplicationController
    before_action :authenticate_member!

  end
end