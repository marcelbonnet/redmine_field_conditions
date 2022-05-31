class RedmineFieldConditionsController < ApplicationController

	include RedmineFieldConditions::Utils

	before_action :prepare_conditions

	def edit_custom_field
	end

	def add_blank_condition
	end

	def remove_rule
		@position = params['rule']
	end

	private

	def prepare_conditions
		params_to_conditions(params)
	end

end

