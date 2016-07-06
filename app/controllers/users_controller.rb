class UsersController < ApplicationController

  def new
    erb :"users/new"
  end

  def create
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect "/"
    else
      @errors = @user.errors.full_messages
      erb :"users/new"
    end
  end


  def show
    @user = User.find_by(id: params[:id])
    @questions = @user.questions.order("created_at desc")
    erb :"users/show"
  end

  def edit
    @user = User.find_by(id: params[:id])
    erb :"users/edit"
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.assign_attributes(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      redirect "/users/#{@user.id}"
    else 
      erb :"users/edit"
    end
  end

end
