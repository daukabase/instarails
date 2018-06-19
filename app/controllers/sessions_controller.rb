class SessionsController < ApplicationController

  def new
  end

  def create
    login = params[:session][:login]
    if login.include? "@"
      user = User.find_by_email(login)
    else
      user = User.find_by_username(login)
    end

    if user && user.authenticate(params[:session][:password])
      #login
      sign_in user
      redirect_to user
    else
      flash[:error] = "Invalid username or password"
      render "new"
    end

  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
