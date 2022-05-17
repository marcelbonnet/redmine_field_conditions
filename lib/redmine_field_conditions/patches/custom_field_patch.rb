module RedmineFieldConditions
	module Patches
		module CustomFieldPatch
			
			def self.included(base)
				base.extend(ClassMethods)
				base.send :prepend, InstanceMethods
				base.class_eval do
					store :conditions, accessors: [:rules, :expr], coder: JSON
					safe_attributes 'conditions'
				end
			end

			module InstanceMethods
				
			end

			module ClassMethods

			end

		end
	end
end