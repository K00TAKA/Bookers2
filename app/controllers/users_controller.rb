class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @user = current_user
    @users = User.all
    @user_image = @user.image
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @user = current_user
    @book = Book.new
    @books = @user.books
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
    @user_image = @user.image
  end
  
  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to books_path
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
  
  def is_matching_login_user
    user_id = params[:id]
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
  
end
