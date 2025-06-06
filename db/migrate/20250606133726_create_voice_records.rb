class CreateVoiceRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :voice_records do |t|
      t.string :title
      t.text :original_text
      t.text :summary_text
      t.text :speakers
      t.string :user_name
      t.datetime :recorded_at

      t.timestamps
    end
  end
end
