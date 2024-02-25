require 'dotenv'
require 'logger'
require 'test_helper'


describe 'authentication' do

  it '#1 use wrong access_code' do
    assert_raises Tibber::AuthenticationError do
      client = Tibber.client( { access_token: Tibber.access_token+"xxx"} )
      client.login
      flunk( 'AuthenticationError expected' )
    end
  end

end
