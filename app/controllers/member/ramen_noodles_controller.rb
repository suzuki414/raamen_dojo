module Member
  class RamennoodlesController < ApplicationController
    before_action :authenticate_member!

  end
end