class VoiceRecord < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :user_name, presence: true, length: { maximum: 100 }
  validates :recorded_at, presence: true

  # デフォルトでタイトルが空の場合は日時を設定
  before_validation :set_default_title, if: -> { title.blank? }

  # JSON形式での話者情報を扱うメソッド
  def speakers_list
    return [] if speakers.blank?
    
    begin
      JSON.parse(speakers)
    rescue JSON::ParserError
      []
    end
  end

  def speakers_list=(list)
    self.speakers = list.to_json
  end

  # 要約の状態確認
  def summarized?
    summary_text.present?
  end

  # 音声認識の状態確認
  def transcribed?
    original_text.present?
  end

  # 検索用スコープ
  scope :by_user, ->(user_name) { where(user_name: user_name) }
  scope :recent, -> { order(created_at: :desc) }
  scope :with_summary, -> { where.not(summary_text: [nil, '']) }

  private

  def set_default_title
    self.title = "音声記録 #{recorded_at&.strftime('%Y/%m/%d %H:%M') || Time.current.strftime('%Y/%m/%d %H:%M')}"
  end
end
