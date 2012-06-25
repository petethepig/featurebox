module FeatureBox
  class CategoriesController < FeatureBox::ApplicationController
    load_and_authorize_resource
    
    def index
      pages_helper do |limit,offset|
        @real_categories = Category.limit(limit).offset(offset)
        @total = Category.count
        @offset = offset
      end
    end
  
    def new
    end
  
    def edit
    end
  
    def create
      @category.name = params[:category][:name]
      if @category.save
        redirect_to categories_path, notice: 'Category was successfully created.' 
      else
        render action: "new" 
      end
    end
  
    def update
      @category.name = params[:category][:name]
      if @category.save
        redirect_to categories_path, notice: 'Category was successfully updated.' 
      else
        render action: "edit" 
      end
    end
  
    def destroy
      @category.destroy
      redirect_to categories_path, notice: 'Category was successfully deleted.'     
    end

  end
end
