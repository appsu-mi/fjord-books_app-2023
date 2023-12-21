# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @report = reports(:test_report)

    visit root_url
    sign_in users(:owner)
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'
    fill_in '内容', with: '作成内容'
    fill_in 'タイトル', with: '作成タイトル'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '作成内容'
    assert_text '作成タイトル'
    click_on '日報の一覧に戻る'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in '内容', with: '編集内容'
    fill_in 'タイトル', with: '編集タイトル'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '編集内容'
    assert_text '編集タイトル'
    click_on '日報の一覧に戻る'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_text '日報が削除されました。'
    assert_text '日報の一覧'
  end
end
