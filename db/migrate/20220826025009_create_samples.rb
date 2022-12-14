# frozen_string_literal: true

# db/migrate/20220826025009_create_samples.rb
class CreateSamples < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'hstore'
    create_table :samples do |t|
      t.string :name
      t.hstore :histogram
      t.integer :words_count
      t.integer :cycles

      t.timestamps
    end
  end
end
