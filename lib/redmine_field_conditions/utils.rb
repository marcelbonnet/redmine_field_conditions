module RedmineFieldConditions
	module Utils

		class RedmineFieldConditionsMissingParameter < StandardError ; end

		def conditions
			conditions = read_attribute(:conditions)
			conditions.empty? ? init_conditions : conditions
		end

		def conditions=(c)
			conditions = init_conditions
			conditions["enabled"] = (c["enabled"] == '1' || c["enabled"] == true)
			conditions["expr"] = c["expr"]

			unless c["rule_name"].nil?
				c["rule_name"].each_with_index do |name, i|
					conditions['rules'].push( {
						"name" => name.parameterize,
						"rule" => {
							"name" => name,
							"field" => c["rule_field"][i],
							"op" => c["rule_op"][i],
							"val" => c["rule_val"][i],
						}
					})
				end
			end
			write_attribute(:conditions, conditions)
		end

		# @params [ActionController:Parameters] params
		def init_object_from_params(params)
			# se for um campo novo: params traz 
			# 	params['type']="IssueCustomField"
			# 	e params["custom_field"]["field_format"]
			# se for um campo existente, não traz o type. Vou ter que buscar por params["custom_field"]["cf_id"]

			fc = {}
			init_conditions

			param_key = "custom_field"
			param_key = "custom_table" unless params.has_key?param_key

			if not params[param_key]["cf_id"].empty?
				if not params.has_key?("custom_table")
					@custom_field = CustomField.find(params[param_key]["cf_id"])
				else
					@custom_field = CustomTable.find(params[param_key]["cf_id"])
				end
			else
				if not params.has_key?("custom_table")
					@custom_field = CustomField.new
					@custom_field.safe_attributes = params[param_key]
				else
					@custom_field = CustomTable.new
					@custom_field.safe_attributes = params["custom_table"]
				end
			end

		end

		private

		def init_conditions
			conditions = {
					"rules" => [],
					"enabled" => false,
					"expr" => ""
				}
		end
		
	end
end