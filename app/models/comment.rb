# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true
  validates :content, presence: true
end
