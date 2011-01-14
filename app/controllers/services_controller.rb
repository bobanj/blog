class ServicesController < ApplicationController
  def twitter
    begin
      Timeout::timeout(5) do
        @tweets = Twitter.user_timeline(TWITTER_USERNAME).first(3)
      end
      render :layout => false
    rescue Timeout::Error => e
      render :text => TWITTER_ERR_MESSAGE, :status => :service_unavailable
    rescue Errno::ETIMEDOUT => e
      render :text => TWITTER_ERR_MESSAGE, :status => :service_unavailable
    rescue SocketError => e
      render :text => TWITTER_ERR_MESSAGE, :status => :service_unavailable
    rescue NoMethodError => e
      render :text => TWITTER_ERR_MESSAGE, :status => :service_unavailable
    end
  end

end
