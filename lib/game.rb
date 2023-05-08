# frozen_string_literal: true

# provide methods for runnig the game, set secret word,
# check if the player get the word or the game is over
class Game
  include Display
  attr_reader :secret_word, :correct_letters, :wrong_letters, :num_wrong_guesses

  MAX_NUM_GUESSES = 7

  def initialize
    @secret_word = secret_word_get
    @wrong_letters = []
    @correct_letters = Array.new(secret_word.size)
    @num_wrong_guesses = 1
  end

  def start_game(replaying: false)
    pre_game_process(replaying)
    play_game
    post_game_process
  end

  private

  def pre_game_process(replaying)
    load_game unless replaying || new_game?
    draw_board(secret_word, correct_letters, wrong_letters, MAX_NUM_GUESSES)
  end

  def play_game
    loop do
      save_game(self)
      break if game_over? || broken_word?

      guess_set(guess_letter_get)
      draw_board(secret_word, correct_letters, wrong_letters, MAX_NUM_GUESSES)
    end
  end

  def post_game_process
    puts 'Secret Word: '.green + secret_word.green
    puts broken_word? ? 'Well Done!'.win : 'OOPs..You Failed!'.lose
    play_again if play_again?
  end

  def secret_word_get
    words = File.readlines('lib/words.txt').filter do |word|
      (5..12).include?(word.chomp.size)
    end
    words.sample.chomp
  end

  # get the player guess
  def guess_letter_get
    print "Enter Guess letter:\t"
    guess_letter = gets.chomp
    if valid_guess?(guess_letter)
      guess_letter
    else
      puts 'Only one letter is allowed!'.red
      guess_letter_get
    end
  end

  # set the letter to the corresponding variable
  def guess_set(player_guess)
    exit_game if player_guess == 'exit'
    if secret_word.include?(player_guess)
      secret_word.split('').each_with_index do |letter, index|
        @correct_letters[index] = player_guess if letter == player_guess
      end
    else
      @wrong_letters << player_guess
      @num_wrong_guesses += 1
    end
  end

  def game_over?
    num_wrong_guesses > MAX_NUM_GUESSES
  end

  def broken_word?
    secret_word == correct_letters.join
  end

  def valid_guess?(player_guess)
    player_guess.size == 1 || player_guess == 'exit'
  end

  def new_game?
    puts "\n1. New game\n2. Continue game"
    gets.chomp.to_i == 1
  end

  def play_again?
    print 'Do you want to play again?(y/any): '
    gets.chomp == 'y'
  end

  def play_again
    save_game(Game.new)
    load_game
    system('clear || cls')
    start_game(replaying: true)
  end

  def exit_game
    puts 'Exiting game ...'
    puts 'Exited Successfully'
    exit(0)
  end
end
