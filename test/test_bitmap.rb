require 'test/unit'

require './app/bitmap'

class TestBitmap < Test::Unit::TestCase

  def setup
    @bitmap = Bitmap.new(2, 5)
  end

  def test_exposes_bitmap_attr
    assert_nothing_raised { @bitmap.bm }
  end

  def test_exposes_rows_attr
    assert_nothing_raised { @bitmap.rows }
  end

  def test_exposes_cols_attr
    assert_nothing_raised { @bitmap.cols }
  end

  def test_has_rows
    assert_equal(2, @bitmap.rows)
  end

  def test_has_cols
    assert_equal(5, @bitmap.cols)
  end

  def test_initialize
    bm = [["O", "O", "O", "O", "O"], ["O", "O", "O", "O", "O"]]

    assert_equal(bm, @bitmap.bm)
  end
 
  def test_draw_pixel
    bm = [["O", "C", "O", "O", "O"], ["O", "O", "O", "O", "O"]]
    @bitmap.draw_px(1, 2, "C")

    assert_equal(bm, @bitmap.bm)
  end 

  def test_draw_pixel_off_by_one;end

  def test_clear
    bm = [["O", "O", "O", "O", "O"], ["O", "O", "O", "O", "O"]]

    @bitmap.draw_px(1, 1, "C")
    @bitmap.draw_px(1, 2, "C")
    @bitmap.clear

    assert_equal(bm, @bitmap.bm)
  end

  def test_draw_horizontal
    bm = [["O", "C", "C", "C", "C"], ["O", "O", "O", "O", "O"]]

    @bitmap.draw_h(2, 5, 1, "C")

    assert_equal(bm, @bitmap.bm)
  end

  def test_draw_vertical
    bm = [["O", "C", "O", "O", "O"], ["O", "C", "O", "O", "O"]]

    @bitmap.draw_v(2, 1, 2, "C")

    assert_equal(bm, @bitmap.bm)
  end
end
