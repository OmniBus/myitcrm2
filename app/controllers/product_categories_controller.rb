class ProductCategoriesController < ApplicationController
   load_and_authorize_resource

def show
    @product_category = ProductCategory.where(["name LIKE ?", "%#{params[:term]}%"]).order('name ASC')
    respond_to do |format|
      format.js  { render :layout => false }
    end
  end
end
