# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  # GET /books
  def index
    @books = Book.order(:id).page(params[:page])
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_url(@book), notice: t('controllers.common.notice_create', name: Book.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: t('controllers.common.notice_update', name: Book.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: t('controllers.common.notice_destroy', name: Book.model_name.human)
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :memo, :author, :picture)
  end
end
