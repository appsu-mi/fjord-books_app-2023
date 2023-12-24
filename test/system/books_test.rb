# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @book = books(:test_book)
    visit root_url
    sign_in users(:owner)
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test 'should create book' do
    visit books_url
    click_on '本の新規作成'

    fill_in 'メモ', with: 'クリエイト'
    fill_in 'タイトル', with: 'クリエイト'
    fill_in '著者', with: 'owner'
    click_on '登録する'

    assert_text '本が作成されました。'
    click_on '本の一覧に戻る'
  end

  test 'should update Book' do
    visit book_url(@book)
    click_on 'この本を編集', match: :first

    fill_in 'メモ', with: 'アップデート'
    fill_in 'タイトル', with: 'アップデート'
    fill_in '著者', with: 'owner'
    click_on '更新する'

    assert_text '本が更新されました。'
    click_on '本の一覧に戻る'
  end

  test 'should destroy Book' do
    visit book_url(@book)
    click_on 'この本を削除', match: :first

    assert_text '本が削除されました。'
  end
end
