# app/helpers/samples_helper.rb
module SamplesHelper
  def validate_file_type(file)
    file.content_type.in?(%w[text/plain])
  end
end
