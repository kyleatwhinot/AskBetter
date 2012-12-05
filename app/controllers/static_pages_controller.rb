class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @contact = Contact.create
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @contact = Contact.create
    end
  end

  def help
  end

  def about
  end

  def contact_us

  end
end
