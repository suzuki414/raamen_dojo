module Public
  class RamenNoodleCommentsController < ApplicationController
    before_action :authenticate_member!

  end
end