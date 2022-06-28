require 'colorize'

class Tic_tac_toe
private
    @@win=false
    @@chance=0
    @@inputs=[]
    @@play_again='y'

    def initialize
        puts "Hi who wants to play first? Choose x or o"
        puts " "
        choice=gets.chomp
        puts " "
        game_board=[[1,2,3],[4,5,6],[7,8,9]]
        play_game(game_board,choice=="x"? true : false,choice=="o"? true : false )
    end


    #Display board
    def display_board(board)
        3.times do |i|
            3.times do |j|
                print board[i][j].to_s+"   "
        end
        puts " "
        puts " "
    end
    end


    #Find the position where user enters
    def find_pos(board,ele)
        pos=[]
          for i in 0..2
              for j in 0..2
                  if (board[i][j]==ele)
                    pos<<i
                    pos<<j
                    return pos 
                  end
              end
          end
      end



      #Mark O or X
      def mark_o_x(i,user,board,user_x)
        if user_x==true
            board[i[0]][i[1]]=user.green
        else 
            board[i[0]][i[1]]=user.yellow
        end
    end


    #checking game ending conditions
    def end_game(board)
    #check for row and column
    3.times do |i|
        if board[i][0]==board[i][1] && board[i][1]==board[i][2]
            return true
        elsif board[0][i]==board[1][i] && board[1][i]==board[2][i]
            return true
        end
    end
    #check for diagnol
    if board[0][0]==board[1][1] && board[1][1]==board[2][2]
        return true
    elsif board[0][2]==board[1][1] && board[1][1]==board[2][0]
        return true
    end

    return false
    end




    #Game logic
    def play_game(board,user_x,user_o)
     x_score=0
     y_score=0
    while !@@win && @@play_again=='y'
        @@chance=@@chance+1   
        index=[]
        display_board(board)
        correct_response=1
        puts "Player #{user_x==true ? "X": "O"} choose from remaining positions:".blue
        puts " "
        respond=gets.chomp.to_i
    
        
        #Making Sure User selects only the position which is not pre occupied or error input
        if @@inputs.include?respond or respond>9 or respond==0
            correct_response=0
            while correct_response==0
                warn "Wrong input!! Try again".red
                puts " "
                respond=gets.chomp.to_i
                if @@inputs.include?respond or respond>9  or respond==0
                    correct_response=0
                else
                    correct_response=1
                end
                @@inputs<<respond
             end
            else
            @@inputs<<respond
        end
        puts " "
       
        #Getting the index where the user selected
        index=find_pos(board,respond)
        mark_o_x(index, user_x==true ? "X": "O",board,user_x)
        
        #Checking for end game logic

        if end_game(board)==true
            @@win=true
            puts "---------------------------------------------".red
            puts "Player  #{user_x==true ? "X" : "O"} won.".red
            user_x==true ? x_score=x_score+1 : y_score=y_score+1
            puts "Scores: Player x: #{x_score} and Player y: #{y_score}"
            puts "---------------------------------------------".red
            puts " "
            display_board(board) 
            puts " "
            puts "Do you want to play again? Enter y or n"
            @@play_again=gets.chomp
          elsif @@chance==9
            @@win=true
            puts "---------------------------------------------".red
            puts "Draw".red
            puts "---------------------------------------------".red
            puts " "
            display_board(board) 
            puts " "
            puts "Do you want to play again? Enter y or n" 
            @@play_again=gets.chomp
          end

          #See if the players want to play more
          if @@play_again=="y" and @@win
            @@win=false
            board=[[1,2,3],[4,5,6],[7,8,9]]
            @@inputs=[]
            @@chance=0
          end

          #toggle the user playing
          if user_x==true
            user_x=false
            user_o=true
        else
            user_x=true
            user_o=false
        end

       end
    end
end


Tic_tac_toe.new
