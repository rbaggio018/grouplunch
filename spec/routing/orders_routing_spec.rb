require 'spec_helper'

describe 'routing to orders' do

  it 'routes POST /orders to orders#create' do
    expect(:post => '/orders').to route_to(
      :controller => 'orders',
      :action => 'create'
    )
  end
end