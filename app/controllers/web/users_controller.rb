# frozen_string_literal: true

class Web::UsersController < Web::ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @q = Bulletin.ransack(params[:q])

    @bulletins = current_user.bulletins
                             .ransack(params[:q])
                             .result
                             .order(created_at: :desc)
                             .page(params[:page]).per(10)
  end
end
