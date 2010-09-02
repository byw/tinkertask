class ListsController < ApplicationController
  inherit_resources

  

  
  protected
  
    def build_resource
      @list ||= current_user.lists.build(params[:list])
    end
    
    def resource
      @list ||= current_user.lists.find(params[:id])
    end
  
    def collection
      @lists ||= current_user.lists
    end
    
end