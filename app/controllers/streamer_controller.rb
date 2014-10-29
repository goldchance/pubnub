class StreamerController < ApplicationController
  before_filter :subscribe, :only => :index
  
  def index
    
  end

  def publish    
    render :json => $pubnub.publish(
        :channel => params[:pubchannel],
        :callback => lambda {|x|},
        :message => {
            :author => params[:author],
            :message => params[:message]

        }
    )    
  end
  
  def connect
        
    render :json => $pubnub = Pubnub.new(
      :publish_key   => 'demo',
      :subscribe_key => 'demo',
      :uuid => params[:username]
    )    
    
  end
  
  def get_messages
    render :json => Message.all
  end

  def status
    render :text => $pubnub.inspect
  end  
  
  private
  
  def subscribe    
    $pubnub.subscribe(
        :channel => 'params[:pubchannel]',
        :callback => $callback        
    ) unless $pubnub.subscription_running?
  end      
      
  def history
    
    $pubnub.history(
      :channel  => params[:pubchannel],
      :count    => 10, 
      :callback => $callback
    )
  end
  
  def presence
    
    $pubnub.presence(
        :channel  => params[:pubchannel],
        :callback => $callback
    )
  end
  
  def here_now
    
    $pubnub.here_now(
        :channel  => params[:pubchannel],
        :callback => $callback
    )
  end

end
