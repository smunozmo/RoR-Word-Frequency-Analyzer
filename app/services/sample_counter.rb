# app/services/sample_counter.rb
class SampleCounter
  def initialize(sample, total_words = 0, iterations = 0)
    @sample = sample
    @count = Hash.new(0)
    @total_words = total_words
    @iterations = iterations
  end

  def count_from_file(blob)
    words = blob.read
    @total_words = + words.downcase.scan(/\w+/).count
    words.downcase.scan(/\w+/).each do |word|
      count[word] += 1
      @iterations += 1
    end

    return_count
  end

  def count_from_input(input)
    words = input.downcase.scan(/\w+/)
    @total_words = words.count

    words.each do |word|
      count[word] += 1
      @iterations += 1
    end

    return_count
  end

  private

  def return_count
    sample.histogram = count
    sample.words_count = total_words
    sample.cycles = iterations
  end

  attr_accessor :sample, :count, :total_words, :iterations
end
