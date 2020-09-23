class PagesController < ApplicationController
  # app/views/pages/home.html.erb
  def home
    if logged_in?
      @micropost  = current_user.microposts.build #users.newと同じ has_manyを使っている時 build_関連のあるメソッド名
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about 
  end

  def contact
  end
end
