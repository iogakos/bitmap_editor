class Bitmap

  # expose bitmap and dimensions getters
  attr_reader :bm, :rows, :cols

  ## Builds a new bitmap with dimensions [rows x cols]
  def initialize(rows, cols)
    @rows = rows
    @cols = cols

    @bm = create(rows, cols)
  end

  ## Clear the bitmap
  def clear
    @bm = create(@rows, @cols)
  end

  ## Draw a pixel with the given colour
  def draw_px(x, y, colour)
    @bm[x - 1][y - 1] = colour
  end

  ## Draw a vertical segment with the given colour
  def draw_v(x, y1, y2, colour)
    (y1 - 1..y2 - 1).each do |row|
      @bm[row][x - 1] = colour
    end
  end

  ## Draw a horizontal segment with the given colour
  def draw_h(x1, x2, y, colour)
    @bm[y - 1][x1 - 1..x2 - x1] = Array.new(x2 - x1 + 1, colour)
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

    ## Create a new two-dimensional array
    def create(rows, cols)
      return Array.new(rows) { Array.new(cols, "O") }
    end

end
