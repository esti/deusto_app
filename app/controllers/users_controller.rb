class UsersController < ApplicationController
  # Sólo los usuarios conectados pueden ver la lista de usuarios.
  before_filter :login_required, :only => [:index]

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users
  def index
    @users = User.all
  end 

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to login_url, :notice => 'You have successfully signed up'
    else
      render :action => "new" 
    end
  end
end
