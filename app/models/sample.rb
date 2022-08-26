class Sample < ApplicationRecord
    include ActiveModel::Validations
    has_one_attached :text_sample
    validates :id, uniqueness: true
    validates :name, presence: true, format: {with: /\A[0-9a-zA-Z]*\z/}
    validates :words_count, numericality: { only_integer: true }
    validates :cycles, numericality: { only_integer: true }
    validates_with SampleValidator
end