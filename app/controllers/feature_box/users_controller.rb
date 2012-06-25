module FeatureBox
  class UsersController < FeatureBox::ApplicationController
    load_and_authorize_resource
    def index
      pages_helper do |limit,offset|
        @users = User.limit(limit).offset(offset)
        @total = User.count
        @offset = offset
      end
    end

    def edit
    end

    def update
      @user.name = params[:user][:name]
      @user.email = params[:user][:email]
      if @user.save
        redirect_to users_path, notice: 'User info was successfully updated.' 
      else
        render action: "edit" 
      end
    end

    def destroy
      @user.destroy
      redirect_to users_path, notice: 'User was successfully deleted.'     
    end

  end

end