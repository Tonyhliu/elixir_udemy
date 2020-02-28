defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
    `mix docs`
  """

  @doc """
    Returns a list of strings representing a deck of playing cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # for loop in elixir
    # for every el, do block
    # comprehension -> mapping function
    # gets put into brand new array
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end
    # List.flatten(cards)

    for suit <- suits, value <- values do
      # can do as many (mutiple) comprehension as you want. no need to flatten like above
      # similar to double for loop
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the card.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  # save on disk
  def save(deck, filename) do
    # :erlang to call erlang code
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  # read from disk
  # tuple short array of terms, first element usually OK
  def load(filename) do
    # {status, binary} = File.read(filename)
    # # avoid if statement , use pattern matching and case statement
    # case status do
    #   :ok -> :erlang.binary_to_term(binary)
    #   :error -> "That file does not exist!"
    # end

    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "That file does not exist!"
    end
  end

  # atom -> :atom. used to handle control flow, status code. Think of them
  # exactly like strings. Strings to used to put together info to display to user

  def create_hand(hand_size) do
    # want to be able to create list of cards, pass to
    # cards.shuffle, then take that to cards.deal incorporating hand size, and return list of cards
    # values = ["Ace", "Two", "Three", "Four", "Five"]
    # suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # for suit <- suits, value <- values do
    #   "#{value} of #{suit}"
    # end

    # pseudo code
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
