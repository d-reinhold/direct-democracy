class BillsController < ApplicationController
  def update
    bill = Bill.find(params[:id])
    bill.update_attributes(params)
    redis = Redis.new
    redis.publish("bill.update.#{bill.id}", bill.as_json)
    redis.quit
    render nothing: true
  end

  def index
    render json: Bill.all.as_json(include: :tags)
  end
end