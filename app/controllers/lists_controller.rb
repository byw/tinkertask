class ListsController < ApplicationController
  inherit_resources
  include InheritedResources::DSL
  
  update! do |success|
    success.js {render :json => @list}
  end
  
  def reorder
    lists = current_user.lists #cache them in identity map
    new_positions = {}
    params[:lists].each_with_index do |id, index|
      if current_user.lists.find(id)
        new_positions[id] = {:position => index}
      end
    end
    List.update(new_positions)
    render :text => "ok"
  end
  
  protected
  
    def build_resource
      @list ||= current_user.lists.build(params[:list])
    end
    
    def resource
      @list ||= current_user.lists.find(params[:id])
    end
  
    def collection
      @lists ||= current_user.lists.all :order => "position ASC"
    end
    
end