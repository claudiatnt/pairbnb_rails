class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def delete
  end

  def edit
  end

  def update
  end
end
