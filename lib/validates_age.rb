require "active_record"

module Rubykitchen
	module ValidatesAge
		module Validator
			class AgeValidator < ActiveModel::EachValidator
				def validate_each(record, attribute, value)
          if value > Date.today  
            record.errors[attribute] << "As per the DOB you are Not yet Born"
          elsif ((Date.today - value) < 13)
            record.errors[attribute] << "Your age is less than 13"
          elsif ((Date.today - value) > 120)
            record.errors[attribute] << "Your age is older than the oldrst Human Being"
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