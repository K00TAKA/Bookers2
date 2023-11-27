class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  def create
  end
  
  def index
    @user = current_user
  end
  
  def show
  end
  
  def edit
  end
end
