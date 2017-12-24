defmodule TextClient.Player do
  alias TextClient.State
  alias TextClient.Summary
  alias TextClient.Prompter
  alias TextClient.Mover

  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("You WON!!")
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_with_message("Sorry, you lost :(")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Bad guess!")
  end

  def play(game = %State{tally: %{game_state: :already_guessed}}) do
    continue_with_message(game, "You've already guessed that letter.")
  end

  def play(game) do
    continue(game)
  end

  def continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.move()
    |> play()
  end

  def make_move(game) do
    game
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
