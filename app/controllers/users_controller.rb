class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:user_id, :email, :session_token)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @user = User.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @users = User.all
  end

  def new
    # default: render 'new' template 
  end

  def create
    begin
      @user = User.create_user!(user_params)
      flash[:notice] = "Welcome #{@user.user_id}. Your account has been created"
      # redirect_to users_path
      redirect_to login_path
      
    rescue ActiveRecord::RecordInvalid
      flash[:notice] = "user aleady exists"
      redirect_to :back
    end
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes!(user_params)
    flash[:notice] = "#{@user.user_id} was successfully updated."
    # redirect_to movie_path(@movie)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User '#{@user.user_id}' deleted."
    redirect_to users_path
  end

end
