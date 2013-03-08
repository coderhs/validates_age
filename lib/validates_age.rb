require "active_record"

module Rubykitchen
	module ValidatesAge
		module Validator
			class AgeValidator < ActiveModel::EachValidator
				def validate_age value
          if value > Time.now 
          	messages << "According to the Age provided the person is not born"
          elsif ((Time.now-value) < 13)
          	messages << "The person is not old enough to join this website"
          elsif ((Time.now-value) > 130)
            messages << "The age entered is unrealestic"
          end
				end
			end
		end

		module ClassMethods
			def validates_age_of(*attr_names)
				validates_with ActiveRecord::Base::AgeValidator, _merge_attributes(attr_names)
			end
		end
	end
end

ActiveRecord::Base.send(:include, Rubykitchen::ValidatesAge::Validator)
ActiveRecord::Base.send(:extend, Rubykitchen::ValidatesAge::ClassMethods)