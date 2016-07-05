require 'test/unit'

require './app/bitmap_editor'

class TestBitmapEditor < Test::Unit::TestCase

  def setup
    # suppress STDOUT
    $stdout = StringIO.new

    @be = BitmapEditor.new
  end

  def test_create
    bm = [["O", "O", "O", "O", "O"], ["O", "O", "O", "O", "O"]]

    @be.run_cmd("I", ["2", "5"])

    assert_equal(bm, @be.bm.bm)
  end

  def test_draw_pixel
    bm = [["O", "C", "O", "O", "O"], ["O", "O", "O", "O", "O"]]

    @be.run_cmd("I", ["2", "5"])
    @be.run_cmd("L", ["1", "2", "C"])

    assert_equal(bm, @be.bm.bm)
  end

  def test_clear
    bm = [["O", "O", "O", "O", "O"], ["O", "O", "O", "O", "O"]]

    @be.run_cmd("I", ["2", "5"])
    @be.run_cmd("L", ["1", "2", "C"])
    @be.run_cmd("C")

    assert_equal(bm, @be.bm.bm)
  end

  def test_draw_horizontal
    bm = [["O", "C", "C", "C", "C"], ["O", "O", "O", "O", "O"]]

    @be.run_cmd("I", ["2", "5"])
    @be.run_cmd("H", ["2", "5", "1", "C"])

    assert_equal(bm, @be.bm.bm)
  end

  def test_draw_vertical
    bm = [["O", "C", "O", "O", "O"], ["O", "C", "O", "O", "O"]]

    @be.run_cmd("I", ["2", "5"])
    @be.run_cmd("V", ["2", "1", "2", "C"])

    assert_equal(bm, @be.bm.bm)
  end

  def test_unrecognized_command
    assert_false(@be.run_cmd("-"))
  end

  def test_valid_command
    assert_true(@be.run_cmd("I", ["2", "5"]))
  end

  def test_invalid_command
    assert_false(@be.run_cmd("I"))
  end

  def test_parse_command_multiple_args
    assert_equal(["I", ["2", "5"]], @be.send(:parse_cmd, "I 2 5"))
  end

  def test_parse_command_no_args
    assert_equal(["X", []], @be.send(:parse_cmd, "X"))
  end

  def test_command_create_is_valid
    assert_true(@be.send(:is_valid_cmd?, "I", ["2", "5"]))
  end

  def test_command_create_fails_with_invalid_dimensions
    assert_false(@be.send(:is_valid_cmd?, "I", ["2", "50000"]))
  end

  def test_command_create_with_letter_as_pixel_is_invalid
    assert_false(@be.send(:is_valid_cmd?, "I", ["2", "a5"]))
  end

  def test_command_create_with_wrong_number_of_arguments_invalid
    assert_false(@be.send(:is_valid_cmd?, "I", ["2"]))
  end

  def test_command_draw_pixel_is_valid
    @be.run_cmd("I", ["2", "5"])

    assert_true(@be.send(:is_valid_cmd?, "L", ["1", "2", "C"]))
  end

  def test_command_draw_pixel_with_wrong_number_of_arguments_invalid
    assert_false(@be.send(:is_valid_cmd?, "L", ["1", "2"]))
  end

  def test_command_draw_pixel_with_lowercase_colour_is_invalid
    @be.run_cmd("I", ["2", "5"])

    assert_false(@be.send(:is_valid_cmd?, "L", ["1", "2", "c"]))
  end

  def test_command_draw_horizontal_is_valid
    @be.run_cmd("I", ["2", "5"])

    assert_true(@be.send(:is_valid_cmd?, "H", ["2", "5", "1", "C"]))
  end

  def test_command_draw_horizontal_with_wrong_number_of_arguments_invalid
    assert_false(@be.send(:is_valid_cmd?, "H", ["2", "5", "1"]))
  end

  def test_command_draw_vertical_is_valid
    @be.run_cmd("I", ["2", "5"])

    assert_true(@be.send(:is_valid_cmd?, "V", ["2", "1", "2", "C"]))
  end

  def test_command_draw_vertical_with_wrong_number_of_arguments_invalid
    assert_false(@be.send(:is_valid_cmd?, "V", ["2", "1", "2"]))
  end

end
