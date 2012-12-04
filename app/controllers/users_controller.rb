class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    puts "in UsersController:new"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #Handle success
    else
      render 'new'
    end
  end
end