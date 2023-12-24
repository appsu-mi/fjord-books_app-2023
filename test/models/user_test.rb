# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'return email if no name' do
    assert_equal 'alice', users(:alice).name_or_email
    assert_equal 'bar@example.com', users(:no_name).name_or_email
  end
end
