require File.expand_path('api', __dir__)
require File.expand_path('const', __dir__)
require File.expand_path('error', __dir__)

module Tibber
  # Wrapper for the Tibber REST API
  #
  # @see https://developer.tibber.com/docs/overview
  class Client < API
    attr_accessor :information

    def initialize(options = {})
      super(options)
      login
      @information = self.info
    rescue GraphQLError => e
      raise AuthenticationError.new e
    end

  private
    def self.api_endpoint(method, query)

      # all records
      self.send(:define_method, method) do |params = {}|
        r = graphql_call(query, params)
      end
    end

  public
    # return device information
    # product_type
    # product_name
    # serial
    # firmware_version
    # api_version
    # devices: HWE-P1, HWE-SKT,	HWE-WTR, HWE-KWH1 and SDM230-wifi,	HWE-KWH3 and SDM630-wifi
    api_endpoint :info, '
    {
      viewer {
        name
        userId
        login
        accountType
        websocketSubscriptionUrl
        homes {
          id
          timeZone
          appNickname
          appAvatar
          size
          type
          numberOfResidents
          primaryHeatingSource
          hasVentilationSystem
          mainFuseSize
          address {
            address1
            address2
            address3
            city
            postalCode
            country
            latitude
            longitude
          }
          meteringPointData {
            consumptionEan
            gridCompany
            gridAreaCode
            priceAreaCode
            productionEan
            energyTaxType
            vatType
            estimatedAnnualConsumption
          }
          features {
            realTimeConsumptionEnabled
          }
          subscriptions {
            id
            validFrom
            validTo
            status
            priceRating {
              thresholdPercentages {
                high low
              }
              hourly {
                minEnergy maxEnergy
                minTotal maxTotal
                currency
              }
              daily {
                minEnergy maxEnergy
                minTotal maxTotal
                currency
              }
              monthly {
                minEnergy maxEnergy
                minTotal maxTotal
                currency
              }
            }
          }
        }
      }
    }'
    api_endpoint :price_info, '
      {
        viewer {
          homes {
            id
            currentSubscription{
              priceInfo{
                current{
                  startsAt
                  total
                  energy
                  tax
                  currency
                }
                today {
                  startsAt
                  total
                  energy
                  tax
                  currency
                }
                tomorrow {
                  startsAt
                  total
                  energy
                  tax
                  currency
                }
              }
            }
          }
        }
      }'
    api_endpoint:_send_push_notification, '
    mutation {
      sendPushNotification(input: {
        title: "%{title}",
        message: "%{message}",
        screenToOpen: %{screen_to_open}
      }){
        successful
        pushedToNumberOfDevices
      }
    }'
    def send_push_notification(title, message, screen_to_open)
      _send_push_notification({ title: title, message: message, screen_to_open: screen_to_open }).sendPushNotification
    end
    api_endpoint :_consumption, '
      {
        viewer {
          home(id:"%{id}") {
            consumption(resolution: %{resolution}, last: %{count}) {
              nodes {
                from
                to
                cost
                unitPrice
                unitPriceVAT
                consumption
                consumptionUnit
              }
            }
          }
        }
      }'
    def consumption(home_id, resolution, count)
      _consumption({ id: home_id, resolution: resolution, count: count })
    end
  end
end
