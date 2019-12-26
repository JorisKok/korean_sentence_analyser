defmodule KoreanSentenceAnalyser.DataTypes.Substantive do
  alias KoreanSentenceAnalyser.DataTypes.Josa
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Substantive"
  @moduledoc """
  A substantive can be a given name, or a family name
  """

  @doc """
  Find if the word is a substantive
  """
  def find(word) do
    with nil <- given_name(word),
         nil <- family_name(word),
         do: nil
  end

  @doc """
  Find if the word is a substantive, removing any Josa (grammar) attached to the word
  """
  def find_without_josa(word) do
    with nil <- given_name(word, true),
         nil <- family_name(word, true),
         do: nil
  end

  @doc """
  Find if the word is a given name
  """
  def given_name(word, remove_josa \\ false) do
    find(word, "data/substantives/given_names.txt", "Given name", remove_josa)
  end

  @doc """
  Find if the word is a family name
  """
  def family_name(word, remove_josa \\ false) do
    find(word, "data/substantives/family_names.txt", "Family name", remove_josa)
  end
  
  defp find(word, file, type, remove_josa) do
    case remove_josa do
      true -> find_with_removing_josa(word, file, type)
      false -> find_basic(word, file, type)
    end
  end
  
  defp find_basic(word, file, type) do
    word
    |> Dict.find_in_file(file)
    |> Formatter.print_result(@data_type, type)
  end
  
  defp find_with_removing_josa(word, file, type) do
    word
    |> Josa.remove()
    |> Dict.find_in_file(file)
    |> Formatter.print_result(@data_type, type)
  end
end
