module Public
  class MembersController < ApplicationController
    before_action :authenticate_member!
    
    def my_page
      @member = current_member
    end
    
    def edit
      @member = current_member
    end
    
    def update
      @member = current_member
    end

  end
end