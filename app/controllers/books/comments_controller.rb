# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  before_action :set_book, only: %i[create destroy]
  # POST /books/1/comments
  def create
    @comment = @book.comments.build(comment_params)

    @comment.save!
    redirect_to book_url(@book), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
  end

  # DELETE /books/1/comments/1
  def destroy
    comment = current_user.comments.find(params[:id])

    comment.destroy!
    redirect_to book_url(@book), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
