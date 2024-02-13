module Public
  class MembersController < ApplicationController
    before_action :authenticate_member!
    
    def index
      @members = Member.page(params[:page]).per(12)
    end
    
    def show
      @member = Member.find(params[:id])
    end  
    
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