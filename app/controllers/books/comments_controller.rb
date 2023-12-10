# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  # POST /books/1/comments
  def create
    book = Book.find(params[:book_id])
    @comment = book.comments.build(comment_params)
    if @comment.save
      redirect_to @comment.target, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render @comment.target, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
