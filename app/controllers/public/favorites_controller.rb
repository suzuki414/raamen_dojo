module Public
  class FavoritesController < ApplicationController
    before_action :authenticate_member!

  end
end