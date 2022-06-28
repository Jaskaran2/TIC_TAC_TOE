def play_the_game
    
    board=[[1,2,3],[4,5,6],[7,8,9]]
    win=false
    user_x=false
    user_o=true
    chance =0
    inputs=[]


#display the board
def display_board(board)
    z=[]
    for i in 0..2
        for j in 0..2
            z<< board[i][j]
    end
    puts z.join("   ")
    z=[]
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


#setting the user symbol
def mark_o_x(i,user,board,user_x,user_o)
    if user_x==true
        board[i[0]][i[1]]=user
    else 
        board[i[0]][i[1]]=user
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
    puts "Player #{user_x==true ? "x": "o"} choose from remaining positions:"
    respond=gets.chomp.to_i


    
    #Making Sure User selects only the position which is not pre occupied or error input
    if inputs.include?respond or respond>9 or respond==0
        correct_response=0
        while correct_response==0
            puts "Wrong inout!! Try again"
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
   

    index=find_pos(board,respond)
    mark_o_x(index, user_x==true ? "x": "o",board,user_x,user_o)
    
    #Checking for end game logic
    if end_game(board)==true
        win=true
        puts "Player  #{user_x==true ? "x": "o"} won" 
        display_board(board)
      elsif chance==9
        win=true
        puts "Draw"
        display_board(board)
      end

    # setting user      
    if user_x==true
        user_x=false
        user_o=true
    else
        user_x=true
        user_o=false
    end
    
   end
end

play_the_game






