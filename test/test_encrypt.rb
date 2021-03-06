require 'minitest_helper'

# From: http://csrc.nist.gov/groups/ST/toolkit/BCM/documents/proposedmodes/ffx/aes-ffx-vectors.txt

class TestEncrypt < Minitest::Test
  def setup
    key = "2b7e151628aed2a6abf7158809cf4f3c"
    tweak = "9876543210"
    @ec = FFXCodec::Encrypt.new(key, tweak, 10, 10)
  end

  def test_nist_vector1
    assert_equal("6124200773", @ec.encrypt("0123456789"))
  end

  def test_nist_vector2
    @ec.tweak = ""
    assert_equal("2433477484", @ec.encrypt("0123456789"))
  end

  def test_nist_vector3
    @ec.tweak = "2718281828"
    @ec.length = 6
    assert_equal("535005", @ec.encrypt("314159"))
  end

  def test_nist_vector4
    @ec.tweak = "7777777"
    @ec.length = 9
    assert_equal("658229573", @ec.encrypt("999999999"))
  end

  def test_nist_vector5
    @ec.radix = 36
    @ec.tweak = "TQF9J5QDAGSCSPB1"
    assert_equal("C8AQ3U846ZWH6QZP".downcase, @ec.encrypt("C4XPWULBM3M863JH"))
  end

  def test_raises_argumenterror_when_key_too_small
    assert_raises ArgumentError do
      @ec.key = "2b7e151628aed2a6abf7158809cf4f"
    end
  end

  def test_raises_argumenterror_when_key_big
    assert_raises ArgumentError do
      @ec.key = "22b7e151628aed2a6abf7158809cf4f3ce"
    end
  end

  def test_raises_argumenterror_when_radix_too_big
    assert_raises ArgumentError do
      @ec.radix = 65537
    end
  end
end
