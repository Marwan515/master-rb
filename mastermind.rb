
class CodeMaker
    @@code = ""
    def generate_code()
        @@code = 4.times.map{1 + Random.rand(6)}
    end
    
    def set_code(scode)
        @@code = scode
        puts "your Code IS #{@@code}"
    end

    def check_guess(guess)
        code = @@code
        if code == guess
            return true
        else
            give_feedback(guess)
        end
    end

    private

    def give_feedback(guess)
        code = @@code
        feedback = Array.new
        for i in (0..3)
            if code[i] == guess[i]
                feedback << "✓"
            elsif code.include? guess[i]
                feedback << "O"
            else
                feedback << "X"
            end
        end
        feedback
    end
end

class Codebreaker

    @@possible_guesses = Array.new

    def initialize ()
        for i in (1111..6666)
            @@possible_guesses << i
        end
    end

    def guess_code()
        guess = @@possible_guesses[Random.rand(@@possible_guesses.length - 1)]
    end
end

def game()
    
    puts "Welcome to Mastermind"
    puts "These are the rules"
    puts "The aim of the game is to set or crack a 4 digit code with numbers between 1 and 6"
    puts "Choose between being the Codebreaker or the Codemaker"
    puts "If you choose to be the Codemaker, input a 4 digit code and see the Computer try and crack it :)"
    puts "If you choose to be the Codebreaker you have 10 turns to try and crack the code set by the computer"
    puts "On each try the computer will provide you feedback on how close you are to cracking the code"
    puts "The feedback is as follows"
    puts "✓ - this means that one of the numbers you inputted is correct and in the right position"
    puts "O - this means that one of the numbers you inputted is correct but in the wrong position"
    puts "X - this means that one of the numbers you inputted is not part of the code"
    puts "Are you ready? let's play!"
    puts ""

    puts "Do you want to be the codebreaker? (y/n)"

    player_type = gets.chomp.downcase
    
    if player_type == "y"

        computer = CodeMaker.new()

        computer.generate_code()

    else
        player = CodeMaker.new()

        computer = Codebreaker.new()

        puts "Set the code"

        player_code = gets.chomp.split(//).map{|num| num.to_i}

        while player_code.length != 4
            puts "Wrong input, please input a 4 digit code with numbers between 1 and 6"
            player_code = gets.chomp.split(//).map{|num| num.to_i}
        end

        player.set_code(player_code)
    end

    turns = 10

    while turns != 0

        if computer.class == CodeMaker

            puts "Guess the code!"

            player_guess = gets.chomp.split(//).map{|num| num.to_i}

            while player_guess.length != 4
                puts "Wrong input! Please input 4 numbers between 1 and 6"
                player_guess = gets.chomp.split(//).map{|num| num.to_i}
            end

            if computer.check_guess(player_guess) == true
                puts ""
                puts "You guessed the code!"
                break
            else
                puts ""

                puts "Wrong code"

                message = computer.check_guess(player_guess)

                puts "feedback: #{message.join(" ")}"

                turns -= 1

                unless turns <= 1 
                    puts "You have #{turns} more turns!"
                    puts ""
                end
            end
        end

        if computer.class == Codebreaker

            computer_guess = computer.guess_code()

            puts "Computer guess is #{computer_guess}"

            if player.check_guess(computer_guess) == true
                puts "Computer guessed the code!"
                break
            else
                puts ""
                puts "Wrong code"
                message = player.check_guess(computer_guess)
                puts "feedback: #{message.join(" ")}"
                turns -= 1
                unless turns <= 1 
                    puts "You have #{turns} more turns!"
                    puts ""
                end
            end
        end
    end
end

game()