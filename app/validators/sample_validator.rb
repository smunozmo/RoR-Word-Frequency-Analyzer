# app/validators/sample_validator.rb
class SampleValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :name, "There's a problem with the histogram." unless record.histogram.instance_of?(::Hash)
  end
end
