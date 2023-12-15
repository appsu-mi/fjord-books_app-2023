# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'has editing authority' do
    assert reports(:test_report).editable?(users(:owner))
    assert_not reports(:test_report).editable?(users(:other))
  end

  test 'created_at to date_object' do
    assert_equal reports(:test_report).created_at.to_date, reports(:test_report).created_on
  end
end
