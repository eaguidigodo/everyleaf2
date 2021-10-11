class Admin::UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]
    skip_before_action :login_required, only: [ :new, :create]

    def index
        redirect_to tasks_path, notice: 'only the administrator can access it' if current_user.is_admin != true
        @users = User.all.where.not(id: current_user.id)
    end
    
    def show
        @tasks = @user.tasks.all
    end
  
    def new
      if current_user&.is_admin 
        @user = User.new
      elsif current_user ==nil
        @user = User.new
      else
        redirect_to tasks_path
      end
    end
  
    def edit
    end
  
    def create
      @user = User.new(user_params)
      
      respond_to do |format|
        if @user.save
          if current_user == nil 
            session[:user_id] = @user.id
          end
          format.html { redirect_to tasks_path, notice: "User was successfully created." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_users_path, notice: "Changed user information" }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :is_admin)
    end
    
end