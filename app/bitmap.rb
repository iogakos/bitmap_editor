class Bitmap

  # expose bitmap and dimensions getters
  attr_reader :bm, :rows, :cols

  # Builds a new bitmap with dimensions [`rows` x `cols`]
  #
  # @param rows [Integer] bitmap rows
  # @param cols [Integer] bitmap cols
  def initialize(rows, cols)
    @rows = rows
    @cols = cols

    @bm = create(rows, cols)
  end

  # Clear the bitmap
  #
  # Clear the bitmap by creating a new one, GC will take care of the rest.
  def clear
    @bm = create(@rows, @cols)
  end

  # Draw a pixel with the given colour
  #
  # @param x [Integer] x coordinate of the pixel to colour
  # @param y [Integer] y coordinate of the pixel to colour
  def draw_px(x, y, colour)
    @bm[x - 1][y - 1] = colour
  end

  # Draw a vertical segment with the given colour
  #
  # Draw a vertical segment with the given colour by iterating through rows
  # `y1` to `y2` and drawing pixel in column `x` with `colour`.
  #
  # @param x [Integer] column of the vertical segment
  # @param y1 [Integer] row where drawing begins
  # @param y2 [Integer] row where drawing ends
  # @param colour [String] single capital character indicating the colour
  def draw_v(x, y1, y2, colour)
    (y1 - 1..y2 - 1).each do |row|
      @bm[row][x - 1] = colour
    end
  end

  # Draw a horizontal segment with the given colour
  #
  # Draw a horizontal segment with the given colour by iterating through
  # columns `x1` to `x2` and drawing pixel in row `y` with `colour`.
  #
  # @param x [Integer] column of the vertical segment
  # @param y1 [Integer] row where drawing begins
  # @param y2 [Integer] row where drawing ends
  # @param colour [String] single capital character indicating the colour
  def draw_h(x1, x2, y, colour)
    @bm[y - 1][x1 - 1..x2 - 1] = Array.new(x2 - x1 + 1, colour)
  end

  ## Print the bitmap
  def show
    @bm.each do |row|
      row.each do |px|
        print px
      end
      print "\n"
    end
  end

  private

    ## Create a new two-dimensional array that represents a bitmap
    def create(rows, cols)
      return Array.new(rows) { Array.new(cols, "O") }
    end

end
