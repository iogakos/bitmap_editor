require './app/bitmap'

class BitmapEditor

  MAX_ROWS = 250
  MAX_COLS = 250

  attr_reader :bm

  # Builds a `BitmapEditor` objects that exposes an interface for bitmap
  # manipulation.
  def initialize
    @bm = nil
    @running = true
  end

  def run
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp
      cmd, args = parse_cmd(input)

      run_cmd(cmd, args)
    end
  end

  # Runs a command with the given arguments
  #
  # Runs a command with the given arguments and performs validation checks on
  # `cmd` and `args`. Returns false if the command along with its corresponding
  # arguments does not represent a valid command, or if the command given
  # depends on an already created bitmap which has not been previously
  # initialized, or if the command given is not supported by the interface. For
  # every correctly constructed commmand, the corresponding operation on the
  # bitmap is performed.
  #
  # @param cmd [String] string representing the command, e.g., "C" or "I"
  # @param args [Array[String]] array of arguments that follow certain
  #   commands, e.g., ["2", 5"] should be provided along with a value of "I"
  #   for `cmd` to create a bitmap of size 2x5
  #
  # @return [Boolean] true if command successfully executed, false otherwise
  #
  def run_cmd(cmd, args = [])
    done = true

    if !is_valid_cmd?(cmd, args)
      puts "Command ", cmd, " is not valid"
      done = false
    else
      if (cmd == 'C' ||
          cmd == 'L' ||
          cmd == 'V' ||
          cmd == 'H' ||
          cmd == 'S') &&
          !@bm

          puts 'Bitmap not initialized'
          done = false
      elsif cmd == 'I'
        @bm = Bitmap.new(args[0].to_i, args[1].to_i)
      elsif cmd == 'C'
        @bm.clear
      elsif cmd == 'L'
        @bm.draw_px(args[0].to_i, args[1].to_i, args[2])
      elsif cmd == 'V'
        @bm.draw_v(args[0].to_i, args[1].to_i, args[2].to_i, args[3])
      elsif cmd == 'H'
        @bm.draw_h(args[0].to_i, args[1].to_i, args[2].to_i, args[3])
      elsif cmd == 'S'
        @bm.show
      elsif cmd == '?'
        show_help
      elsif cmd == 'X'
        exit_console
      else
        puts 'unrecognised command :('
        done = false
      end
    end

    return done
  end

  private

  # Parse command
  #
  # Split `input` into two parts. The first part is a string representing the
  # format and the second argument is an array of strings that contains the
  # arguments that might accompany the command
  #
  # @param input [String] the input string
  #
  # @return [String, Array] an array whose first element is the command and
  #   second element is an array of arguments
  def parse_cmd(input)
    input = input.split
    cmd = input[0]
    args = input[1..-1]

    return cmd, args
  end

  # Validate commands and its arguments
  #
  # Given the command string and its arguments, perform validation checks for
  # each corresponding command. Each command receive specific number of
  # arguments. Bitmap dimensions should not exceed `MAX_ROWS` and `MAX_COLS`
  # in case of bitmap initialization. Accordingly, pixel/segment coordinates
  # should not exceed the initialized bitmap's dimensions. Pixel coordinates
  # can only be numerical values, and colours can only be capitalized latin
  # letters. Note: A non-listed command is considered as valid.
  #
  # @param cmd [String] string representing the command, e.g., "C" or "I"
  # @param args [Array[String]] array of arguments that follow certain
  #   commands, e.g., ["2", 5"] should be provided along with a value of "I"
  #   for `cmd` to create a bitmap of size 2x5
  #
  # @return [Boolean] true if command is valid, false otherwise
  def is_valid_cmd?(cmd, args = [])
    valid = false

    if cmd == 'I'
      if args.length == 2 &&
        args[0] =~ /^\d+$/ &&
        args[1] =~ /^\d+$/
        (rows = args[0].to_i) >= 1 && rows <= MAX_ROWS &&
        (cols = args[0].to_i) >= 1 && cols <= MAX_COLS

        valid = true
      end
    elsif cmd == 'L'
      if args.length == 3 &&
        args[0] =~ /^\d+$/ &&
        args[1] =~ /^\d+$/ &&
        (col = args[0].to_i) > 0 && col <= @bm.cols &&
        (row = args[1].to_i) > 0 && row <= @bm.rows &&
        args[2] =~ /^[A-Z]{1}$/

        valid = true
      end
    elsif cmd == 'V'
      if args.length == 4 &&
        args[0] =~ /^\d+$/ &&
        args[1] =~ /^\d+$/ &&
        args[2] =~ /^\d+$/ &&
        (col = args[0].to_i) > 0 && col <= @bm.cols &&
        (row = args[1].to_i) > 0 && row <= @bm.rows &&
        (row = args[2].to_i) > 0 && row <= @bm.rows &&
        args[3] =~ /^[A-Z]{1}$/

        valid = true
      end
    elsif cmd == 'H'
      if args.length == 4 &&
        args[0] =~ /^\d+$/ &&
        args[1] =~ /^\d+$/ &&
        args[2] =~ /^\d+$/ &&
        (col = args[0].to_i) > 0 && col <= @bm.cols &&
        (col = args[1].to_i) > 0 && col <= @bm.cols &&
        (row = args[2].to_i) > 0 && row <= @bm.rows &&
        args[3] =~ /^[A-Z]{1}$/

        valid = true
      end
    elsif cmd == '?' || cmd == 'C' || cmd == 'S' || cmd == 'X'
      if args.empty?
        valid = true
      end
    else
      valid = true
    end

    return valid
  end

  # Sets `running` attribute to false to trigger console exit
  def exit_console
    puts 'goodbye!'
    @running = false
  end

  # Print to STDOUT the following help message
  def show_help
    puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
  end
end
