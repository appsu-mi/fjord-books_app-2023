# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_report, only: %i[create destroy]
  # POST /reports/1/comments
  def create
    @comment = @report.comments.build(comment_params)

    @comment.save!
    redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
  end

  # DELETE /reports/1/comments/1
  def destroy
    comment = current_user.comments.find(params[:id])

    comment.destroy!
    redirect_to report_url(@report), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_report
    @report = Report.find(params[:report_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
