# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report = reports(:test_report)
    @mentioned_report = reports(:mentioned_report)
  end

  test '#editable?' do
    assert reports(:test_report).editable?(users(:owner))
    assert_not reports(:test_report).editable?(users(:other))
  end

  test '#created_on' do
    assert_equal Date.parse(reports(:test_report).created_at.to_s), reports(:test_report).created_on
  end

  test '#save_mentions report_create' do
    @user = users(:alice)
    report = @user.reports.create(title: 'タイトル', content: "http://localhost:3000/reports/#{@mentioned_report.id}")

    assert report.mentioning_reports.find(@mentioned_report.id)
  end

  test '#save_mentions report_update_and_destroy_mention' do
    assert_equal @report.content, '内容'
    assert_not @report.mentioning_reports.find_by(id: @mentioned_report.id)

    @report.update(title: 'タイトル', content: "http://localhost:3000/reports/#{@mentioned_report.id}")
    assert @report.mentioning_reports.find(@mentioned_report.id)

    @report.update(title: 'タイトル', content: '内容')
    assert_not @report.mentioning_reports.find_by(id: @mentioned_report.id)
  end
end
