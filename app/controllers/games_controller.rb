require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @include = includes?(@word, @letters)
    @english_word = english_word?(@word)
  end

  def includes?(word, letters)
    word.split("").all? { |l| letters.include?(l) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json["found"]
  end
end
