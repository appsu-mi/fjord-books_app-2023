# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  has_many :active_mentions, class_name: 'Mention', foreign_key: 'mentioning_id', dependent: :destroy, inverse_of: :mentioning
  has_many :passive_mentions, class_name: 'Mention', foreign_key: 'mentioned_id', dependent: :destroy, inverse_of: :mentioned

  has_many :mentioning_reports, through: :active_mentions, source: :mentioned
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioning

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def execute_save_procedure
    transaction do
      save
      create_mention
    end
  end

  def execute_update_procedure(report_params)
    transaction do
      update(report_params)
      create_mention
    end
  end

  def create_mention
    search_for_url.each do |mention_id|
      active_mentions.create(mentioned_id: mention_id)
    end
  end

  def search_for_url
    url = URI.extract(content, ['http'])
    url.map { |u| u.split('/').last }
  end

  def update_mention(content)
    mentioning_report_ids.each do |id|
      active_mentions.find_by(mentioned_id: id).destroy! unless content.include? "http://localhost:3000/reports/#{id}"
    end
  end
end
