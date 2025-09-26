# frozen_string_literal: true

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
    # new prices for tomorrow are available  around 13:00
    tomorrow_count = (Time.now.hour >= 13) ? 24 : 0
    assert value(subscription.tomorrow.count).must_equal(tomorrow_count), 'prices for tomorrow is >13:00'
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

  it "#5 empty graph ql call exception" do
    assert_raises Tibber::GraphQLError do
      @client.graphql_call('')
      flunk( 'GraphQLError expected' )
    end
  end

  it "#6 config" do
    assert _(@client.config[:endpoint]).must_equal Tibber::DEFAULT_ENDPOINT
  end
end
