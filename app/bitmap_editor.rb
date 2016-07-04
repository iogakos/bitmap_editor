require './app/bitmap'

class BitmapEditor

  def run
    @bm = nil
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp
      cmd, args = parse_cmd(input)

      if (cmd == 'C' ||
          cmd == 'L' ||
          cmd == 'V' ||
          cmd == 'H' ||
          cmd == 'S') &&
          !@bm

          puts 'Bitmap not initialized'
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
      end
    end
  end

  private

    ## Parse command
    def parse_cmd(input)
      input = input.split
      cmd = input[0]
      args = input[1..-1]

      return cmd, args
    end

    def exit_console
      puts 'goodbye!'
      @running = false
    end

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
