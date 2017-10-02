class SessionsController < ApplicationController
  def session_params
    params.require(:user).permit(:user_id, :email)
  end
  
  def new
      # new will be associated with establishing login sessions
  end
    
  def create
    @user = User.where({user_id: session_params[:user_id],email: session_params[:email]}).first
    
    if @user==nil
      flash[:notice]= "Invlaid user-ID/email combination."
      redirect_to :back
    else
      flash[:notice] = "Welcome #{@user.user_id}."
      session[:session_token] = @user.session_token
      redirect_to movies_path
    end
  end

  def destroy
      # destroy will handle the logout process
      reset_session
      flash[:notice]= "You have been logged out"
      redirect_to movies_path
  end
end