# frozen_string_literal: true

class CommentsController < ApplicationController
  # POST /reports/{id}/comments
  def create
    @comment = find_target.comments.build(comment_params)
    if @comment.save
      redirect_to @comment.target, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render @comment.target, status: :unprocessable_entity
    end
  end

  # DELETE /reports/{report_id}/comments/{comment_id}
  def destroy
    comment = Comment.find(params['id'])

    redirect_to comment.target, notice: t('errors.messages.unauthorized') and return if comment.user.id != current_user.id

    comment.destroy!
    redirect_to comment.target, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def find_target
    params.key?('report_id') ? Report.find(params['report_id']) : Book.find(params['book_id'])
  end
end
