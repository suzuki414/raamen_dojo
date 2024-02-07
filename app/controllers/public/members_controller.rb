module Public
  class MembersController < ApplicationController
    before_action :authenticate_member!

  end
end