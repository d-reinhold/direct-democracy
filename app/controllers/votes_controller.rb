class VotesController < ApplicationController
  def create
    if params[:citizen_id]
      puts 'creating citizen vote'
      Vote.create!(citizen_id: params[:citizen_id], bill_id: params[:bill_id], value: params[:value])
    else
      puts 'creating rep vote'
      Vote.create!(rep_id: params[:citizen_id], bill_id: params[:bill_id], value: params[:value])
    end
    render nothing: true
  end

  def index
    render json: Vote.all.as_json
  end
end
