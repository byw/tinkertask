class ItemsController < ApplicationController
  inherit_resources
  include InheritedResources::DSL
  
  create! do |success|
    success.js {render :partial => "lists/item", :object => @item}
  end
  
  update! do |success|
    success.js {render :json => resource}
  end
  
  def reorder
    new_items = params[:items].map do |id|
      list.items.find(id)
    end
    list.items = new_items
    list.save
    render :text => "ok"
  end
  
  protected
  
    def resource
      @item ||= list.items.find(params[:id])
    end
  
    def list
      @list ||= current_user.lists.find(params[:list_id])
    end
  
    def build_resource
      @item ||= list.items.build(params[:item])
    end
end