module RedmineFieldConditions
	module Patches
		module CustomFieldsControllerPatch
			
			def self.included(base)
				base.extend(ClassMethods)
				base.send :prepend, InstanceMethods
				base.class_eval do
					include RedmineFieldConditions::Utils
					# before_action :prepare_conditions, :only => [:create, :update]
					# before_action :init_conditions, :only => [:new]
				end
			end

			module InstanceMethods

			  private

				# def prepare_conditions
				# 	params_to_conditions(params)
				# end
				
			end

			module ClassMethods

			end

		end
	end
end