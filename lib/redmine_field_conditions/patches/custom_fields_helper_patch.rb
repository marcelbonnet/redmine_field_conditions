module RedmineFieldConditions
	module Patches
		module CustomFieldsHelperPatch
			
			def self.included(base)
				base.extend(ClassMethods)
				base.send :prepend, InstanceMethods
				base.class_eval do
					include RedmineFieldConditionsHelper
				end
			end

			module InstanceMethods

			end

			module ClassMethods

			end
			
		end
	end
end