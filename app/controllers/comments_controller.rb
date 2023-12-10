# frozen_string_literal: true

class CommentsController < ApplicationController
  # DELETE /targets/1/comments/1
  def destroy
    comment = current_user.comments.find(params[:id])

    comment.destroy!
    redirect_to comment.target, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end
end
