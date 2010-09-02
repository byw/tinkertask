class ItemsController < ApplicationController
  inherit_resources
  include InheritedResources::DSL
  
  create! do |success|
    success.js {render :partial => "lists/item", :object => @item}
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
  
    def list
      @list ||= current_user.lists.find(params[:list_id])
    end
  
    def build_resource
      @item ||= list.items.build(params[:item])
      @item.user = current_user
      @item
    end
end