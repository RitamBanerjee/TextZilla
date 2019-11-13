Provider_1_Weight = 0.7
Provider_1 = "https://jo3kcwlvke.execute-api.us-west-2.amazonaws.com/dev/provider1"
Provider_2 = "https://jo3kcwlvke.execute-api.us-west-2.amazonaws.com/dev/provider2"

module Texts
  class ProvidersService

    def self.provider
      if rand > Provider_1_Weight
        Provider_1
      else
        Provider_2
      end
    end

    def self.fail_over_provider(failed_provider)
      return Provider_2 if failed_provider == Provider_1

      Provider_1
    end
  end
end
