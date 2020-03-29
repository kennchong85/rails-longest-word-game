require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    all_alphabets = ('a'..'z').to_a
    @letters = all_alphabets.sample(10)
  end

  def checkletters(attempt, letters)
    attempt_array = attempt.downcase.split('').sort
      letters_array = letters.downcase.split('').sort

    # you need to make sure all the letters in the word are in the original array
    # you need to make sure that the count in the letters are equal or less than the original array

    # iterate through the characters in the word
    # if the count of the characters is equal or less than the grid
    # all is good
    # otherwise, return an erro
    #

    # Enumerable#all?


    attempt_array.each_with_index do |letter, index|
      attempt_array.delete_at(index) if letters_array.include?(letter)
    end
    attempt_array.empty?
    raise
  end

  def score
    @user_attempt = params[:answer].downcase
    url = "https://wagon-dictionary.herokuapp.com/#{@user_attempt}"

    user_seralized = open(url).read
    user = JSON.parse(user_seralized)
    @result = { time: 0.0, score: 0, message: '', header: '' }
    checkletters(@user_attempt, params['letters'])

    if user['found'] == false
      @result[:message] = 'You have entered an invalid word! So dumb!!!'
      @result[:header] = 'WRONG! (Trump style)'
      @result[:score] = 0
    else
      if checkletters(@user_attempt, params['letters']) == false
        @result[:header] = 'WRONG! (Trump style)'
        @result[:message] = 'Can you even follow instructions?!?! Fake News!'
        @result[:score] = 0
      else
        @results[:header] = 'Trump Smiles...'
        @results[:message] = 'Making Words Great Again!'
        @result[:score] = 100
      end
    end
  end
end
