require 'rails_helper'

RSpec.describe Sample, type: :model do
    it 'is valid with valid attributes' do
        sample = Sample.new(name: 'Test', words_count: 10, cycles: 20, histogram: {"a"=>"1", "b"=>"2"})
        expect(sample).to be_valid
    end

    it 'is invalid without a name' do
        sample = Sample.new(name: nil, words_count: 10, cycles: 20, histogram: {"a"=>"1", "b"=>"2"})
        expect(sample).not_to be_valid
    end
    
    it 'is invalid with special characters in name' do
        sample = Sample.new(name: "name+", words_count: 10, cycles: 20, histogram: {"a"=>"1", "b"=>"2"})
        expect(sample).not_to be_valid
    end

    it 'is invalid without an integer for words_count' do
        sample = Sample.new(name: 'Test', words_count: "a", cycles: 20, histogram: {"a"=>"1", "b"=>"2"})
        expect(sample).not_to be_valid
    end

    it 'is invalid without an integer for cycles' do
        sample = Sample.new(name: 'Test', words_count: 10, cycles: "a", histogram: {"a"=>"1", "b"=>"2"})
        expect(sample).not_to be_valid
    end

    it 'is invalid with an array for histogram' do
        sample = Sample.new(name: 'Test', words_count: 10, cycles: "a", histogram: ["a", "b"])
        expect(sample).not_to be_valid
    end

end
