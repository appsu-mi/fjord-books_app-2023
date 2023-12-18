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

  def save_include_mention!
    transaction do
      save_mention! if save
    end
  end

  def update_include_mention!(report_params)
    transaction do
      update_mention! if update(report_params)
    end
  end

  private

  def save_mention!
    extract_mention_ids(content).each do |mention_id|
      active_mentions.create!(mentioned_id: mention_id)
    end
  end

  def update_mention!
    active_mentions.each(&:destroy!)
    save_mention!
  end

  DETECTED_DOMAIN = %r{http://localhost:3000/reports/\d+}

  def extract_mention_ids(content)
    url = content.scan(DETECTED_DOMAIN)
    url.map { |u| u.split('/').last }.uniq
  end
end
