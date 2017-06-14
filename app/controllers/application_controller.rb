class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def say_hello
  	render html: "Hey ;)"
  end
end
