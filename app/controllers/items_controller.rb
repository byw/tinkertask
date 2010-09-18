class ItemsController < ApplicationController
  inherit_resources
  include InheritedResources::DSL
  before_filter :require_user
  filter_param :item, :allow => [:body, :complete]
  
  create! do |success|
    success.js {render :partial => "lists/item", :object => @item}
    success.html {redirect_to list_path(list)}
  end
  
  update! do |success|
    success.js {render :json => resource}
    success.html {redirect_to list_path(list)}
  end
  
  def destroy
    list.items.delete_if {|i| i == resource}
    list.save
    if request.xhr?
      render :text => 'ok'
    else
      redirect_to list_path(list)
    end
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
      @item ||= list.items.find(params[:id]) || raise(MongoMapper::DocumentNotFound)
    end
  
    def list
      @list ||= current_user.lists.find!(params[:list_id])
    end
  
    def build_resource
      @item ||= list.items.build(params[:item])
    end
end