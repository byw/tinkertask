class ListsController < ApplicationController
  inherit_resources
  include InheritedResources::DSL
  before_filter :require_user
  filter_param :list, :allow => [:name]
  
  update! do |success, failure|
    success.js {render :json => @list}
    success.html {redirect_to list_path(@list)}
    
    # use old list if validation fails
    failure.js do
      @list.reload
      render :json => @list
    end
  end
  
  destroy! do |success|
    success.js {render :text => 'ok'}
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
      @list ||= current_user.lists.find!(params[:id])
    end
  
    def collection
      @lists ||= current_user.lists.all
    end
    
end