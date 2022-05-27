module RedmineFieldConditions
	module Validator # To be included by CustomField and CustomTable models

		def validate_field_conditions
			names = self.conditions['rules'].collect{|r| r['name'] }

			errors.add(:base, l('redmine_field_conditions.validator.uniq_name')) if names.uniq.count != names.count
		end

	end
end