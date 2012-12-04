class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    puts "in UsersController:new"
    @user = User.new
  end
end