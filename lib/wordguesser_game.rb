class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  MAX_WRONG_GUESSES = 7

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    unless letter.is_a?(String) && letter.match?(/\A[a-zA-Z]\z/)
      raise ArgumentError
    end

    letter = letter.downcase
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      false
    elsif @word.downcase.include?(letter)
      @guesses += letter
      true
    else
      @wrong_guesses += letter
      true
    end
  end

  def word_with_guesses
    @word.chars.map { |c| @guesses.include?(c.downcase) ? c : '-'}.join
  end

  def check_win_or_lose
    if @wrong_guesses.length >= MAX_WRONG_GUESSES
      :lose
    elsif !@word.empty? && @word.chars.all? { |c| @guesses.include?(c.downcase) }
      :win
    else
      :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord.txt')
    Net::HTTP.get(uri)
  end
end
