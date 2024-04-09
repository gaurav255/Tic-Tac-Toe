class GamesController < ApplicationController
  before_action :load_game, only: [:show, :play]

  def show
  end

  def play
    row, col = params[:move].split(',').map(&:to_i)
    current_player = session[:current_player] = (session[:current_player] == 'X' ? 'O' : 'X')
    if @game.make_move(row, col, current_player)
      if @game.game_over?
        flash[:notice] = @game.winner ? "#{@game.winner} wins!" : "It's a draw!"
      end
      save_game
    else
      flash[:alert] = "Invalid move!"
    end
    redirect_to root_path
  end

  def reset
    session.clear
    redirect_to root_path
  end

  private

  def load_game
    @game = Game.new(session[:game_board], session[:game_winner])
  end

  def save_game
    session[:game_board] = @game.board
    session[:game_winner] = @game.winner
  end
end
