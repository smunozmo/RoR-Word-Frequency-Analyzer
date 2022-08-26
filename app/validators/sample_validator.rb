class SampleValidator < ActiveModel::Validator
    def validate(record)
      unless record.histogram.class.name == "Hash"
        record.errors.add :name, "There's a problem with the histogram."
      end
    end
end