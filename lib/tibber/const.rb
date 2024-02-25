
module Tibber
  class Enum
      def self.enum(array)
        array.each do |c|
          const_set c,c
        end
      end
  end
  class Screens < Enum
    enum %w[HOME REPORTS CONSUMPTION COMPARISON DISAGGREGATION HOME_PROFILE CUSTOMER_PROFILE METER_READING NOTIFICATIONS INVOICES]
  end
  class Resolution < Enum
    enum %w[HOURLY DAILY WEEKLY MONTHLY ANNUAL]
  end
  class HomeType < Enum
    enum %w[APARTMENT ROWHOUSE HOUSE COTTAGE]
  end
  class Avatar < Enum
    enum %w[APARTMENT ROWHOUSE FLOORHOUSE1 FLOORHOUSE2 FLOORHOUSE3 COTTAGE CASTLE]
  end
end
