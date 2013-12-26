require 'spec_helper'

describe 'routing to root' do

  it 'routes / to orders#new' do
    expect(get: '/').to route_to(
      controller: 'orders',
      action: 'new'
    )
  end
end