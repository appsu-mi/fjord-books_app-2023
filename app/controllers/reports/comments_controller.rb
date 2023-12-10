# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  # POST /reports/1/comments
  def create
    report = Report.find(params[:report_id])
    @comment = report.comments.build(comment_params)
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
