class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      remember(user)
      flash[:success] = 'welcome!'
      redirect_to user
    else
      # create error message
      flash.now[:danger] = 'you failed to login'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
