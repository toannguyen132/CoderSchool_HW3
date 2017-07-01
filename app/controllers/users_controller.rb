class UsersController < ApplicationController
  def new
    @user = User.new(name: Faker::Name.name, email: Faker::Internet.email)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created, now you can log in"
      redirect_to new_session_path
    else
      flash[:error].now = "There are errors occurred, please check your provided information"
      render new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
