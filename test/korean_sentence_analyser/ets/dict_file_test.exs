defmodule DictFileTest do
  use ExUnit.Case
  import AssertValue

  describe "We can find values in the dictionaries - " do
    test "화염레오" do
      assert_value KSA.DictFile.find("화염레오", "noun/pokemon.txt") == "화염레오"
    end

    test "When we find nothing" do
      assert_value KSA.DictFile.find("blabla", "noun/pokemon.txt") == nil
    end

    test "When we give an empty string, it should give us nil" do
      assert_value KSA.DictFile.find("", "noun/pokemon.txt") == nil
    end
  end
end
