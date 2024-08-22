class Game
  attr_reader :turns_left, :code_maker, :code_breaker

  def initialize
    @turns_left = 12
  end

  def play
    choose_role
    @code_maker.create_code
    until game_over?
      code_breaker.make_guess
      provide_feedback
      @turns_left -= 1
    end
    puts game_over_message
  end

  private

  def choose_role
    puts "Do you want to be the CodeMaker (1) or CodeBreaker (2)?"
    role = gets.chomp.to_i
    if role == 1
      @code_maker = HumanCodeMaker.new
      @code_breaker = ComputerCodeBreaker.new
    else
      @code_maker = ComputerCodeMaker.new
      @code_breaker = HumanCodeBreaker.new
    end
  end

  def provide_feedback
    feedback = Feedback.new(code_maker.secret_code, code_breaker.guess)
    feedback.generate_feedback
  end

  def game_over?
    code_breaker.guess == code_maker.secret_code || turns_left.zero?
  end

  def game_over_message
    if code_breaker.guess == code_maker.secret_code
      "Congratulations! You cracked the code!"
    else
      "Out of turns! The code was: #{code_maker.secret_code.join(", ")}"
    end
  end
end

class CodeMaker
  attr_reader :secret_code

  def initialize
    @secret_code = []
  end
end

class ComputerCodeMaker < CodeMaker
  def create_code
    colors = %w[red blue green yellow orange purple]
    @secret_code = 4.times.map { colors.sample }
    puts "The computer has created a secret code."
  end
end

class HumanCodeMaker < CodeMaker
  def create_code
    puts "Enter your secret code (choose 4 colors from: red, blue, green, yellow, orange, purple):"
    @secret_code = gets.chomp.split
  end
end

class CodeBreaker
  attr_reader :guess

  def initialize
    @guess = []
  end
end

class HumanCodeBreaker < CodeBreaker
  def make_guess
    puts "Enter your guess (choose 4 colors from: red, blue, green, yellow, orange, purple):"
    @guess = gets.chomp.split
  end
end

class ComputerCodeBreaker < CodeBreaker
  def make_guess
    colors = %w[red blue green yellow orange purple]
    @guess = 4.times.map { colors.sample }
    puts "Computer's guess: #{@guess.join(", ")}"
  end
end

class Feedback
  def initialize(secret_code, guess)
    @secret_code = secret_code
    @guess = guess
  end

  def generate_feedback
    exact_matches = exact_match_count
    color_matches = color_match_count - exact_matches
    puts "Exact matches: #{exact_matches}, Color matches: #{color_matches}"
  end

  private

  def exact_match_count
    exact_matches = 0
    @guess.each_with_index do |color, index|
      exact_matches += 1 if color == @secret_code[index]
    end
    exact_matches
  end

  def color_match_count
    color_matches = 0
    secret_code_copy = @secret_code.dup
    @guess.each do |color|
      if secret_code_copy.include?(color)
        color_matches += 1
        secret_code_copy.delete_at(secret_code_copy.index(color))
      end
    end
    color_matches
  end
end

# Start the game
game = Game.new
game.play
