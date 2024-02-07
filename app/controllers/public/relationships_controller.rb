module Public
  class RelationshipsController < ApplicationController
    before_action :authenticate_member!

  end
end