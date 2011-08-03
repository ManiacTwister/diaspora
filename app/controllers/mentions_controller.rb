#   Copyright (c) 2011, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

class MentionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    puts params.inspect
    @aspect_ids = current_user.aspect_ids
    @aspect = :all
    mentions =  Mention.where(:person_id => current_user.person.id).limit(15).order('created_at desc')
    mentions = mentions.where('created_at <= ?', Time.at(params[:max_time].to_i)) if params[:max_time].present?
    mentions = mentions.includes(:post => [{:author => :profile}, :photos, :mentions])
  
    posts = mentions.map{|m| m.post}
    pp posts
    @selected_people = posts.map{|p| p.author}.uniq
    @selected_people_count = @selected_people.count
    @posts = PostsFake.new(posts)
    render 'aspects/index'
  end
end

