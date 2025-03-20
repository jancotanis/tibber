# frozen_string_literal: true

module Tibber
  # The `Enum` class provides a way to define constant-based enumerations dynamically.
  class Enum
    # Defines constants from an array of symbols or strings.
    #
    # @param array [Array<Symbol, String>] List of values to be set as constants.
    # @example
    #   class Colors < Enum
    #     enum %w[RED GREEN BLUE]
    #   end
    #
    #   Colors::RED   # => "RED"
    #   Colors::GREEN # => "GREEN"
    #
    # The above example dynamically defines constants `RED`, `GREEN`, and `BLUE` inside the `Colors` class.
    def self.enum(array)
      array.each do |cnst|
        const_set cnst, cnst
      end
    end
  end

  # The `Screens` class defines a set of screen names as constants.
  # It inherits from `Enum` and uses the `enum` method to define constants dynamically.
  class Screens < Enum
    # Defines screen names as constants.
    #
    # @example Usage:
    #   Screens::HOME            # => "HOME"
    #   Screens::REPORTS         # => "REPORTS"
    #   Screens::NOTIFICATIONS   # => "NOTIFICATIONS"
    #
    # This dynamically defines the following constants:
    # - HOME
    # - REPORTS
    # - CONSUMPTION
    # - COMPARISON
    # - DISAGGREGATION
    # - HOME_PROFILE
    # - CUSTOMER_PROFILE
    # - METER_READING
    # - NOTIFICATIONS
    # - INVOICES
    enum %w[
      HOME REPORTS CONSUMPTION COMPARISON DISAGGREGATION
      HOME_PROFILE CUSTOMER_PROFILE METER_READING NOTIFICATIONS INVOICES
    ]
  end

  # The `Resolution` class defines different time resolutions as constants.
  # It inherits from `Enum` and dynamically sets constants using `enum`.
  #
  # @example Usage:
  #   Resolution::HOURLY   # => "HOURLY"
  #   Resolution::DAILY    # => "DAILY"
  class Resolution < Enum
    # Defines time resolution constants:
    # - HOURLY
    # - DAILY
    # - WEEKLY
    # - MONTHLY
    # - ANNUAL
    enum %w[HOURLY DAILY WEEKLY MONTHLY ANNUAL]
  end

  # The `HomeType` class defines different types of homes as constants.
  #
  # @example Usage:
  #   HomeType::APARTMENT   # => "APARTMENT"
  #   HomeType::HOUSE       # => "HOUSE"
  class HomeType < Enum
    # Defines home type constants:
    # - APARTMENT
    # - ROWHOUSE
    # - HOUSE
    # - COTTAGE
    enum %w[APARTMENT ROWHOUSE HOUSE COTTAGE]
  end

  # The `Avatar` class defines different avatar types as constants.
  #
  # @example Usage:
  #   Avatar::COTTAGE   # => "COTTAGE"
  #   Avatar::CASTLE    # => "CASTLE"
  class Avatar < Enum
    # Defines avatar type constants:
    # - APARTMENT
    # - ROWHOUSE
    # - FLOORHOUSE1
    # - FLOORHOUSE2
    # - FLOORHOUSE3
    # - COTTAGE
    # - CASTLE
    enum %w[APARTMENT ROWHOUSE FLOORHOUSE1 FLOORHOUSE2 FLOORHOUSE3 COTTAGE CASTLE]
  end
end
