class RepsController < ApplicationController

  def show
    rep = Rep.find(params[:id])
    render json: rep.as_json
  end

  #def update
  #  citizen = Citizen.find(params[:id])
  #  params[:tag_ids] ||= []
  #  added = params[:tag_ids] - citizen.tags.pluck(:id)
  #  removed = citizen.tags.pluck(:id) - params[:tag_ids]
  #  if added.any?
  #    added_tags = Tag.find(added)
  #    citizen.tags << added_tags if added_tags
  #    citizen.save!
  #  elsif removed.any?
  #    removed_tags = Tag.find(removed)
  #    puts 'removed '
  #    puts removed_tags
  #    citizen.tags.delete(removed_tags) if removed_tags
  #    citizen.save!
  #  end
  #  render nothing: true
  #end
end
