module V1
  class AccountController < ApplicationController
    authenticate_request only: [:show]

    def create
    end

    def show
      account = AccountRepository.find(params[:id])

      render json: account, status: :ok
    end
  end
end
