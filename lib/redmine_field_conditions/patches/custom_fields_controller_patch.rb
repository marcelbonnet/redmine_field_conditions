module RedmineFieldConditions
	module Patches
		module CustomFieldsControllerPatch
			
			def self.included(base)
				base.extend(ClassMethods)
				base.send :prepend, InstanceMethods
				base.class_eval do
				end
			end

			module InstanceMethods

			end

			module ClassMethods

			end

		end
	end
end