require 'dotenv'
require 'logger'
require 'test_helper'


describe 'client' do
  before do
    @client = Tibber.client
  end


  it '#1 GET info' do
    info = @client.information
    assert info.homes.count > 0, 'has some homes'
    assert value(info.homes.first.type).must_equal(Tibber::HomeType::HOUSE), 'assume domestic use'
    assert info.websocketSubscriptionUrl['tibber.com'], 'substription url has tiber.com domain'
  end

  it "#2 price info" do
    prices = @client.price_info

    prices.homes.each do |home|
      puts "Today's prices:"
      home.currentSubscription.priceInfo.today.each do |hour|
        puts "#{hour.startsAt} #{hour.total} #{hour.currency} (#{hour.energy} + #{hour.tax})"
      end
    end

    subscription = prices.homes.first.currentSubscription.priceInfo
    now = Time.now.to_s[0..9]
    assert subscription.current.startsAt[now], "current from today '#{subscription.current.startsAt}' vs ''#{now}''"

    assert value(subscription.today.count).must_equal(24), 'prices for 24 hrs'
    assert value(subscription.tomorrow.count).must_equal(24), 'prices for 24 hrs'
  end

  it "#2 consumption info" do
    consumption = @client.consumption(@client.information.homes.first.id, Tibber::Resolution::HOURLY, 24).home.consumption
    assert value(consumption.nodes.count).must_equal(24), 'consumption for 24 hrs'
  end

  it "#4 send_push_notification(title, message, screen_to_open)" do
    result = @client.send_push_notification('title', 'message', Tibber::Screens::HOME)
    assert result.successful
    assert result.pushedToNumberOfDevices != 0
  rescue Tibber::GraphQLError => e
    puts e.inspect
    assert e.to_s['not allowed for demo ']
  end

end
