module Public
  class TagsController < ApplicationController
    before_action :authenticate_member!

  end
end