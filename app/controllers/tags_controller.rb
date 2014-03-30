class TagsController < ApplicationController

  def index
    render json: Tag.all.as_json
  end
end
