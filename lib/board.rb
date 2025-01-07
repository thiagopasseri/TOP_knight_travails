WHITE = "\u001b[47;1m   \u001b[0m"
BLACK = "\u001b[40m   \u001b[0m"
GREEN = "\u001b[42m   \u001b[0m"
YELLOW = "\u001b[43m   \u001b[0m"
RED = "\u001b[41m   \u001b[0m"
BLUE = "\u001b[44m   \u001b[0m"



class Board
  attr_accessor :position, :all_squares, :knight_vectors

  def initialize
    @all_squares = generate_all_squares
    @knight_vectors = [[2,1], [2,-1], [-2,1], [-2,-1], [1, 2], [-1, 2], [1, -2], [-1, -2]]
    @board = refresh_board
    @visited_positions = []
  end

  # def move(vector)
  #   position[0] += vector[0]
  #   position[1] += vector[1]
  # end
  

  def refresh_board(round_moves = nil, color = nil)
    board = {}
    (0..7).each do |y|
      (0..7).each do |x|
        board[[x,y]] = BLACK if (x + y) % 2 == 0
        board[[x,y]] = WHITE if (y + x + 1) % 2 == 0
      end
    end

    if round_moves && color
      paint_board(round_moves, color)
    end

    board
  end

  def paint_board(round_moves, color)
    (0..7).each do |y|
      (0..7).each do |x|
        @board[[x,y]] = color if round_moves.include?([x,y])
      end
    end
  end

  def draw
    puts 
    (0..7).each do |y|
      (0..7).each do |x|
          print @board[[x,y]]
          print "\n" if (x + 1) % 8  == 0
      end
    end
  end

  def move(position, vector)

    x, y = position[0] + vector[0], position[1] + vector[1]
    return [x,y] if good_square?([x,y])
    nil
  end

  def good_square?(position)
    @all_squares.include?(position)
  end

  def knight_moves(initial_square, final_square)
    traverse([initial_square], final_square).select {|item| item[-1] == final_square}
  end
  

  def traverse(initial_position, final_position)
    current_position_history_set = [initial_position]
    current_final_position_set = final_position_set(current_position_history_set)

    until(current_final_position_set.include?(final_position))
      # puts
      # puts "final position: #{final_position}"
      # puts "final_position_set:"
      # p current_final_position_set
      # puts
      # puts "TESTE: #{current_final_position_set.include?(final_position)}"
    
      current_position_history_set = all_moves_memory(current_position_history_set)
      current_final_position_set = final_position_set(current_position_history_set)
      
      # puts
      # puts "current_position_history_set:"
      # p current_position_history_set
      # puts

      # puts "current_final_position_set:"
      # p current_final_position_set
      # puts

    end
    current_position_history_set
  end

  def final_position_set(position_history_set)
    final_position_set = position_history_set.map do |position_history|
      position_history[-1]
    end
    final_position_set
  end

  def all_moves_memory(position_history, vectors = @knight_vectors)
    arr = []
    visited_positions = []

    case position_history 
    in [x, y] if x.is_a?(Integer) && y.is_a?(Integer)

      vectors.each do |vector|
        new_position = move(position_history, vector)
        new_position_history = [position_history, new_position]
        arr << new_position_history unless new_position.nil? || visited_positions.include?(new_position)

        visited_positions << new_position
        visited_positions.uniq!
      end
    in Array => position_history
      position_history.each do |position|
        vectors.each do |vector|
          new_position = move(position[-1], vector)
          new_position_history = position +  [new_position]
          arr << new_position_history unless new_position.nil? 

          visited_positions << new_position
          visited_positions.uniq!
        end
      end
    else
      raise ArgumentError, "position deve ser [x,y] ou [[x1,y1]...]"
    end
    arr
  end


  # def draw_board(squares = nil)
  #   puts 
  #   white = "\u001b[47;1m   \u001b[0m"
  #   black = "\u001b[40m   \u001b[0m"
  #   green = "\u001b[42m   \u001b[0m"
  #   yellow = "\u001b[43m   \u001b[0m"
  #   red = "\u001b[41m   \u001b[0m"
  #   blue = "\u001b[44m   \u001b[0m"
  #   colors = [green, yellow, blue, red]
  #   black_white = [black, white]
  #   count = 0
  #   (0..7).each do |y|
  #     (0..7).each do |x|
  #       if squares&.include?([x,y]) 
  #         print green         
  #       else
  #         print black_white[(x + count)%2]
  #       end
  #       print "\n" if (x + 1) % 8  == 0
  #     end
  #     count += 1
  #   end
  # end

  def generate_all_squares
    squares = []
    (0..8).each do |x|
      (0..8).each do |y|
        squares << [y,8-x]
      end
    end
    squares
  end

  def all_moves(position, vectors = @knight_vectors)
    arr = []
    visited_positions = []
    case position 
    in [x, y] if x.is_a?(Integer) && y.is_a?(Integer)
      # puts "all_moves: position"      
      vectors.each do |vector|
        new_position = move(position, vector)
        arr << new_position unless new_position.nil? || visited_positions.include?(new_position)

        visited_positions << new_position
        visited_positions.uniq!
      end
    in Array => positions
      puts "all_moves: array de array"     
      p positions
      puts
      positions.each do |position|
        vectors.each do |vector|
          new_position = move(position, vector)
          arr << new_position unless new_position.nil? || visited_positions.include?(new_position)

          visited_positions << new_position
          visited_positions.uniq!
        end
      end
      p arr.uniq
      puts
    else
      raise ArgumentError, "position deve ser [x,y] ou [[x1,y1]...]"
    end

    arr.uniq
  end

  # def all_moves(position, vectors)
  #   arr = []

  #   case position 
  #   in [x,y]
  #     puts "all_moves: position"      
  #     vectors.each do |vector|
  #       new_position = move(position, vector)
  #       arr << new_position unless new_position.nil?
  #     end
  #   in Array => positions
  #     puts "all_moves: array de array"      

  #     vectors.each do |vector|
  #       position.each do |position|
  #         new_position = move(position, vector)
  #         arr += new_position unless new_position.nil?
  #       end
  #     end
  #   else
  #     raise ArgumentError, "position deve ser [x,y] ou [[x1,y1]...]"
  #   end
  #   arr
  # end
end

