#   Copyright (c) 2011, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

class MentionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @aspect_ids = current_user.aspect_ids
    @aspect = :all
    posts = Post.joins(:mentions).where(:mentions => {:person_id => current_user.person.id}).order('posts.created_at desc').includes({:author => :profile}, :comments).limit(15)
    posts = posts.where('posts.created_at < ?', Time.at(params[:max_time].to_i)) if params[:max_time].present?

    @selected_people = posts.map{|p| p.author}.uniq
    @selected_people_count = @selected_people.count
    @posts = PostsFake.new(posts)
    render 'aspects/index'
  end
end

