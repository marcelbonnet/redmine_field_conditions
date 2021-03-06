module RedmineFieldConditions
	module Patches
		module CustomTablePatch
			
			def self.included(base)
				base.extend(ClassMethods)
				base.send :prepend, InstanceMethods
				base.class_eval do
					include RedmineFieldConditions
					include RedmineFieldConditions::Utils
					include RedmineFieldConditions::Validator
					store :conditions, accessors: [:rules, :expr], coder: JSON
					safe_attributes 'conditions'
					validate :validate_field_conditions
				end
			end

			module InstanceMethods

				# Overrides CustomTable#visible_to?
				# Returns true if the Tables Conditions for exhibition are satisfied
			  def visible_to?(issue)
			    return true if User.current.admin?
			    return check_condition(self.conditions, issue)
			  end

			end

			module ClassMethods

			end
			
		end
	end
end