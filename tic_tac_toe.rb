require 'colorize'

#Where the game logic is all controlled
class Play
    attr_accessor :win , :chance , :inputs ,:play_again

    def initialize
        @win=false
        @chance=0
        @inputs=[]
        @play_again='y'
        puts "Hi who wants to play first? Choose x or o"
        puts " "
        choice=gets.chomp
        puts " "
        game_board=[[1,2,3],[4,5,6],[7,8,9]]
        play_game(game_board,choice=="x"? true : false,choice=="o"? true : false,@win,@chance,@inputs,@play_again )
    end

    def play_game(board,user_x,user_o,win,chance,inputs,play_again)
        
        #craetaing objects
        checkgame=Gamecheck.new
        handleboard= Handleboard.new

       while !win && play_again=='y'
           chance=chance+1   
           handleboard.display_board(board)
           puts "Player #{user_x==true ? "X": "O"} choose from remaining positions:".blue
           puts " "
           respond=gets.chomp.to_i
           correct_response=1
       
           #checking for valid input
           validate_output=checkgame.validate(inputs,respond,correct_response)
           inputs=validate_output[0]
           correct_response=validate_output[1]
           puts " "
          
        #Getting the index where the user selected
        index=handleboard.find_pos(board,respond)
        handleboard.mark_o_x(index, user_x==true ? "X": "O",board,user_x)


        #chhecking if the game has ended
        playagain_win_x_o=checkgame.end(board,win,play_again,chance,handleboard,user_x,user_o)
        play_again=playagain_win_x_o[0]
        win=playagain_win_x_o[1] 
        user_x=playagain_win_x_o[2]
        user_o=playagain_win_x_o[3]          
        
         #See if the players want to play more
        if play_again=="y" and win
            win=false
            board=[[1,2,3],[4,5,6],[7,8,9]]
            inputs=[]
            chance=0
        end
       end
    end
end

  

#handles the board logic such has diplaying the board, getting the position, setting value on board
class Handleboard
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
    
        
    def mark_o_x(i,user,board,user_x)
        if user_x==true
            board[i[0]][i[1]]=user.green
        else 
            board[i[0]][i[1]]=user.yellow
        end
    end

    def display_board(board)
        3.times do |i|
            3.times do |j|
                print board[i][j].to_s+"   "
            end
            puts " "
            puts " "
        end
    end

end
    
   

#Checks whether the game has ended or not
class CheckWin
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
end
    
  
#checks whether the user wants to play more, diplays end result and also checks for valid input
class Gamecheck
    
#Checking for end game logic
def end(board,win,play_again,chance,displayBoard,user_x,user_o) 
    
    #Creting objects
    checkwin=CheckWin.new
    toggle=Toggle.new

    if checkwin.end_game(board)==true
        win=true
        puts "---------------------------------------------".red
        puts "Player  #{user_x==true ? "X" : "O"} won.".red
        puts "---------------------------------------------".red
        puts " "
        displayBoard.display_board(board) 
        puts " "
        puts "Do you want to play again? Enter y or n"
        play_again=gets.chomp
        elsif chance==9
        win=true
        puts "---------------------------------------------".red
        puts "Draw".red
        puts "---------------------------------------------".red
        puts " "
        displayBoard.display_board(board) 
        puts " "
        puts "Do you want to play again? Enter y or n" 
        play_again=gets.chomp
    end
    user_active=toggle.toggle(user_x,user_o)
    return play_again,win,user_active[0],user_active[1]
end


#checking if user enters something invalid
def validate(inputs,respond,correct_response)
    if inputs.include?respond or respond>9 or respond==0
        correct_response=0
        while correct_response==0
            warn "Wrong input!! Try again".red
            puts " "
            respond=gets.chomp.to_i
            if inputs.include?respond or respond>9  or respond==0
                correct_response=0
            else
                correct_response=1
            end
            inputs<<respond
        end
        else
           inputs<<respond
        end
        return inputs,correct_response
    end

end



#Toggles between o and x
class Toggle
    def toggle(user_x,user_o)
         #toggle the user playing
         if user_x==true
            user_x=false
            user_o=true
        else
            user_x=true
            user_o=false
        end
        return user_x,user_o
    end
    
end

#Strat the game
Play.new
