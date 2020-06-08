 require 'json'
 require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = 9.times.map { ('A'..'Z').to_a.sample }
  end

  def is_valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end

  def save_letters(letters)
    array = letters.split(" ")
    return array.join
  end

  def score
    @save_letters = save_letters(params[:letters])
    combination = params[:letters]
    word_letters = params[:word].upcase.split("")
    return @answer = "Sorry but #{params[:word]} doesn't seem to be english" unless is_valid?(params[:word])

    word_letters.each do |letter|
      if combination.include?(letter)
        combination.delete!(letter)
        @answer = "Congratulations! #{params[:word]} is a valid word}"
      else
        @answer = "Sorry but #{params[:word]} can't be built out with #{@save_letters}"
      end
    end
  end

end
