class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      @errors = ["Holy Flapjack! We don't have that email and password combination in our system. Give it another whirl :0)"]
        render "sessions/new"
    end 
  end

  def destroy
    session.clear
    redirect_to '/' 
  end


end
