class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :edit]
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end
  
  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end
  
  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end
  
  def show
    @book = Book.find(params[:id])
    @user = current_user
    # @user = @book.user（この書き方もある
  end
  
  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end
  
  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
    

  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user_id = book.user.id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
end
