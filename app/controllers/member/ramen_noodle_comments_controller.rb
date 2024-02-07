module Member
  class RamennoodlecommentsController < ApplicationController
    before_action :authenticate_member!

  end
end