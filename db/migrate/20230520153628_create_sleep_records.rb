class CreateSleepRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_records do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
