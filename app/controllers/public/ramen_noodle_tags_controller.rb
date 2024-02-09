module Public
  class RamenNoodleTagsController < ApplicationController
    before_action :authenticate_member!

  end
end