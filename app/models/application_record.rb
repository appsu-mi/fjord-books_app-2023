# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def find_comments
    comments.includes(:user).order(created_at: :asc)
  end
end
