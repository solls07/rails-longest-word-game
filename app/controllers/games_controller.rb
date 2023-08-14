require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    @word.split('').each do |letter|
      if @letters.include?(letter.upcase) && english_word?(@word)
        @response = "Congratulations! <b>#{@word.upcase}</b> is a valid English word!".html_safe
      elsif @letters.include?(letter.upcase)
        @response = "Sorry, but <b>#{@word.upcase}</b> is not an English word!".html_safe
      else
        @response = "Sorry, but <b>#{@word.upcase}</b> can't be built out of #{@letters.join(', ')}".html_safe
      end
    end
  end
end

private

def english_word?(word)
response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
json = JSON.parse(response.read)
json['found']
end
