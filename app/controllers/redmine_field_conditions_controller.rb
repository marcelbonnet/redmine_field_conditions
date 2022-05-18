class RedmineFieldConditionsController < ApplicationController

	# before_action :find_custom_field, only: [:edit_custom_field]

	def edit_custom_field
		# se for um campo novo: params traz 
		# 	params['type']="IssueCustomField"
		# 	e params["custom_field"]["field_format"]
		# se for um campo existente, não traz o type. Vou ter que buscar por params["custom_field"]["cf_id"]
		@custom_field = CustomField.new
		@custom_field.safe_attributes = params["custom_field"]
		@conditions = params["custom_field"]["field_conditions"]
	end

	private

	# def find_custom_field
	# 	begin
	# 		@custom_field = CustomField.find(params["custom_field"]["cf_id"])
	# 	rescue ActiveRecord::RecordNotFound
	# 		@custom_field = CustomField.new
	# 		@custom_field.safe_attributes = params["custom_field"]
	# 	end
	# end
	
end

