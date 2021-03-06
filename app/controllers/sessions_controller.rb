# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :logout_guest, only: [:destroy]

  def new; end

  def create
    user = User.find_by_username(params[:username])

    if user&.authenticate(params[:password])
      if user.user?
        session[:user_id] = user.id
        redirect_to root_url, info: 'Welcome Back'
      else
        redirect_to log_in_path, danger: 'Your Account is disabled'
      end
    else
      redirect_to log_in_path, danger: 'Username or Password incorrect'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
