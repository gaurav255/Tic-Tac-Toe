class GamesController < ApplicationController
  before_action :load_game, only: [:index, :play, :create]

  def index
  end

  def create
	  session[:player1] = params[:player1]
	  session[:player2] = params[:player2]
	  redirect_to games_path
	end


  def play
    row, col = params[:move].split(',').map(&:to_i)
    current_player = session[:current_player] = (session[:current_player] == 'X' ? 'O' : 'X')
    if @game.make_move(row, col, current_player)
      if @game.game_over?
        flash[:notice] = @game.winner ? (current_player == 'X' ? "#{session[:player1]} wins!" : "#{session[:player2]} wins!") : "It's a draw!"
      elsif current_player == 'X'
      	flash[:notice] = "#{session[:player2]}'s Turn"
      else
      	flash[:notice] = "#{session[:player1]}'s Turn"
      end
      save_game
    else
      flash[:alert] = "Invalid move!"
    end
    redirect_to games_path
  end

  def reset
    session[:game_board] = nil
    session[:current_player] = nil
    session[:game_winner] = nil
    redirect_to games_path
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
