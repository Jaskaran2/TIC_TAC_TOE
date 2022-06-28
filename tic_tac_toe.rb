require 'colorize'

    
board=[[1,2,3],[4,5,6],[7,8,9]]
win=false
$user_x=false
$user_o=true
chance =0
inputs=[]


#display the board
def display_board(board)
    for i in 0..2
        for j in 0..2
            print board[i][j].to_s+"   "
    end
    puts " "
    puts " "
end
end


#Find the position to set the user symbol
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


#setting the user symbol and setting the player
def mark_o_x(i,user,board)
    if $user_x==true
        board[i[0]][i[1]]=user.green
        $user_x=false
        $user_o=true
    else 
        board[i[0]][i[1]]=user.yellow
        $user_x=true
        $user_o=false
    end
end




#checking game ending conditions
def end_game(board)
    #check for row and column
    for i in 0..2
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
while win==false
    
    chance=chance+1
    index=[]
    display_board(board)
    correct_response=1
    puts "Player #{$user_x==true ? "X": "O"} choose from remaining positions:".blue
    respond=gets.chomp.to_i

    
    #Making Sure User selects only the position which is not pre occupied or error input
    if inputs.include?respond or respond>9 or respond==0
        correct_response=0
        while correct_response==0
            warn "Wrong input!! Try again".red
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
    puts " "
   
    #Getting the index where the user selected
    index=find_pos(board,respond)
    mark_o_x(index, $user_x==true ? "X": "O",board)
    
    #Checking for end game logic
    if end_game(board)==true
        win=true
        puts "Player  #{$user_x==true ? "O" : "X"} won".green
        display_board(board)
      elsif chance==9
        win=true
        puts "Draw".green
        display_board(board)
      end
   end

