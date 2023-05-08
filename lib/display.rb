# frozen_string_literal: true

# provides methods to display all required information
# or draw the board of the game
module Display
  def draw_board(_secret_word, correct_letters, wrong_letters, max_num_guesses)
    puts '============================'
    print 'Incorrect guesses: '.red
    print_wrong_guesses(wrong_letters)
    puts "Number of guesses: #{max_num_guesses - wrong_letters.size}".yellow
    print "\n\t"
    print_correct_letters(correct_letters)
    puts '============================'
    puts "Enter #{'exit'.yellow} to exit the game"
  end

  private

  def print_correct_letters(correct_letters)
    correct_letters.each do |letter|
      print letter || '_ '
    end
    print "\n\n"
  end

  def print_wrong_guesses(wrong_letters)
    wrong_letters.each_with_index do |letter, index|
      print ',' unless index.zero?
      print letter.to_s.red
    end
    puts
  end
end
