class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = 'welcome!'
    else
      # create error message
      flash[:error] = 'you failed to login'
      render 'new'
    end
  end

  def destroy
  end
end
