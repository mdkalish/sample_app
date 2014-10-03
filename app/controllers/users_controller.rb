class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    #debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)   # Not the final implementation!
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # same as redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  private
  # defining the so-called strong parameters
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end

end
