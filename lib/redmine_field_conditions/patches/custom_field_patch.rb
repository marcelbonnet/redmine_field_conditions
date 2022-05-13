module RedmineFieldConditions
	module Patches
		module CustomFieldPatch
			
			def self.included(base)
				base.extend(ClassMethods)
				base.send :include, InstanceMethods
				base.class_eval do
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