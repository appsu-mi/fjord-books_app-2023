# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :target, dependent: :destroy
  validates :title, :content, presence: true
end
