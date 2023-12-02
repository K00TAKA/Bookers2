class UsersController < ApplicationController
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
    @user = User.find(params[:id])
    @user_image = @user.image
  end
  
  def update
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
  
end
