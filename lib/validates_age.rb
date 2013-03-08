require "active_record"

module Rubykitchen
	module ValidatesAge
		module Validator
			class AgeValidator < ActiveModel::EachValidator
				def validate_each(record, attribute, value)
          if value > Date.today  
            record.errors[attribute] << "According to the Age provided the person is not born"
          elsif ((Date.today -value) < 13)
            record.errors[attribute] << "The person is not old enough to join this website"
          elsif ((Date.today -value) > 130)
            record.errors[attribute] << "The age entered is unrealestic"
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