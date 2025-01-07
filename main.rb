require_relative 'lib/board'

board = Board.new

center_square = [0,0]


p board.knight_moves(center_square, [3,3])



# second_move_memory = board.all_moves_memory(first_move_memory)
# p second_move_memory

# puts "last position set:"
# p board.final_position_set(second_move_memory)

# puts

# third_move_memory = board.all_moves_memory(second_move_memory)
# p third_move_memory


# all_second_moves = board.all_moves(all_first_moves)
# all_third_moves = board.all_moves(all_second_moves)
# all_fourth_moves = board.all_moves(all_third_moves)

# board.draw


# board.refresh_board(all_first_moves, YELLOW)
# board.draw

# board.refresh_board(all_second_moves, GREEN)
# board.draw

# board.refresh_board(all_third_moves, BLUE)
# board.draw

# board.refresh_board(all_fourth_moves, RED)
# board.draw








# all_first_moves = board.all_moves(center_square, board.knight_vectors)
# board.draw_board(all_first_moves)


# p board.all_moves(center_square, board.knight_vectors)
# puts

# squares = board.all_moves([center_square], board.knight_vectors )

# squares_2 = board.all_moves(squares, board.knight_vectors )
# board.draw_board(squares_2)

# p squares
# puts

