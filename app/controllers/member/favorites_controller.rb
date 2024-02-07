module Member
  class FavoritesController < ApplicationController
    before_action :authenticate_member!

  end
end