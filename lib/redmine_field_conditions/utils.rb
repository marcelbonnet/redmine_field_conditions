module RedmineFieldConditions
	module Utils

		# @params [ActionController:Parameters] params
		def params_to_conditions(params)
			# se for um campo novo: params traz 
			# 	params['type']="IssueCustomField"
			# 	e params["custom_field"]["field_format"]
			# se for um campo existente, não traz o type. Vou ter que buscar por params["custom_field"]["cf_id"]
			if not params["custom_field"]["cf_id"].empty?
				@custom_field = CustomField.find(params["custom_field"]["cf_id"])
			else
				@custom_field = CustomField.new
				@custom_field.safe_attributes = params["custom_field"]
			end

			# format @conditions for exhibiton

			fc = params["custom_field"]["field_conditions"]
			@conditions = {
				"rules" => [],
				"enabled" => (params["custom_field"]["field_conditions"]["enabled"]== "1"),
				"expr" => params["custom_field"]["field_conditions"]["expr"]
			}
			
			unless fc['rule_name'].nil?
				fc['rule_name'].each_with_index do |name, i|
					@conditions['rules'].push( {
						"name" => name.parameterize,
						"rule" => {
							"name" => name,
							"field" => fc["rule_field"][i],
							"op" => fc["rule_op"][i],
							"val" => fc["rule_val"][i],
						}
					})
				end
			end

			# format parameters to save CustomField attribute conditions
			params["custom_field"]["conditions"] = @conditions
		end

	end
end