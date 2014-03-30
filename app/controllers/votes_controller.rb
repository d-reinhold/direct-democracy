class VotesController < ApplicationController
  def create
    Vote.create!(citizen_id: params[:citizen_id], bill_id: params[:bill_id], value: params[:value])
    render nothing: true
  end

  def index
    render json: Vote.all.as_json
  end
end
