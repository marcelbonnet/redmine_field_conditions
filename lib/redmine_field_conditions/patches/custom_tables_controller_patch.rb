module RedmineFieldConditions
	module Patches
		module CustomTablesControllerPatch
			
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
				# 	# RedmineFieldConditions:
				# 	params_to_conditions(params)
				# 	# CustomTablesController:
				# 	find_custom_table
				# 	# @custom_table = @custom_field
				# 	set_edit_view_variables
				# 	setting_tabs
				# end

			end

			module ClassMethods

			end

		end
	end
end