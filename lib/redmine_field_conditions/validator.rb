module RedmineFieldConditions
	module Validator # To be included by CustomField and CustomTable models

		def validate_field_conditions
			ids = self.conditions['rules'].collect{|r| r['name'] }

			errors.add(:base, l('redmine_field_conditions.validator.uniq_name')) if ids.uniq.count != ids.count
			errors.add(:base, l('redmine_field_conditions.validator.blank_name')) if ids.any?{|n| n.blank? }
			errors.add(:base, l('redmine_field_conditions.validator.space_name')) if self.conditions['rules'].collect{|r| r['rule']['name'] }.any?{|n| n.match(" ") }

		end

	end
end