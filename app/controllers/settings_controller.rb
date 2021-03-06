class SettingsController < ApplicationController
  #  Used by CanCan to restrict controller access
 authorize_resource

  def index
	  #unauthourized! if cannot? :edit, Setting
    @title = "Settings"
        edit
        render :action => 'edit'
  end

  def edit
	  #unauthourized! if cannot? :edit, Setting
     @title = "Settings"
     @priority_list = PriorityList.all
    if request.post? && params[:settings] && params[:settings].is_a?(Hash)
      settings = (params[:settings] || {}).dup.symbolize_keys
      settings.each do |name, value|
        # remove blank values in array settings
        value.delete_if {|v| v.blank? } if value.is_a?(Array)
        Setting[name] = value
      end
      flash[:notice] = "All Good!"
      redirect_to :action => 'index'

 end
 end
 end