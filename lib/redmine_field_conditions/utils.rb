module RedmineFieldConditions
	module Utils

		class CustomFieldHook < Redmine::Hook::Listener

			# include ApplicationHelper

			def init_conditions(params)
				conditions = {'rules' => [] }

				return conditions unless params.has_key?"custom_field"

				fc = params["custom_field"]["field_conditions"]

				conditions = {
					"rules" => [],
					"enabled" => (params["custom_field"]["field_conditions"]["enabled"]== "1"),
					"expr" => params["custom_field"]["field_conditions"]["expr"]
				}

				unless fc['rule_name'].nil?
					fc['rule_name'].each_with_index do |name, i|
						conditions['rules'].push( {
							"name" => name.parameterize,
							"rule" => {
								"name" => name,
								"field" => fc["rule_field"][i],
								"op" => fc["rule_op"][i],
								"val" => fc["rule_val"][i],
							}
						})
					end

					# TODO: vou precisar disso ainda?
					# if not params.has_key?("custom_table")
					# 	# format parameters to save CustomField attribute conditions
					# 	params["custom_field"]["conditions"] = @conditions
					# else
					# 	params["custom_table"]["conditions"] = @conditions
					# end
				end # unless
				conditions
			end

			# def controller_custom_fields_edit_after_save(context={})
			# 	# não posso sobrescrever params aqui. Vai funcionar ler as conditions?
			# 	# RedmineFieldConditions::Utils.init_conditions
			# 	@custom_field = context[:custom_field]
			# 	@custom_field.conditions = init_conditions(context[:params])
			# 	@custom_field.save
			# 	if @custom_field.save
			# 		context[:controller].flash[:notice] = l("redmine_field_conditions.validator.success")
			# 	else
			# 		context[:controller].flash[:error] = @custom_field.errors.full_messages.join('. ')
			# 	end
			# 	# context[:custom_field] = @custom_field
			# end

			# def controller_custom_fields_new_after_save(context={})
			# 	o = context[:custom_field]
			# 	o.conditions = init_conditions(context[:params])
			# 	o.save
			# end
			
			# def controller_custom_tables_edit_after_save(context={})
			# end

			# def controller_custom_tables_new_after_save(context={})
			# end

		end

		# ##############################################################
		# BUG: overrides instance variables for action new before create
		# @params [ActionController:Parameters] params
		def params_to_conditions(params)
			# se for um campo novo: params traz 
			# 	params['type']="IssueCustomField"
			# 	e params["custom_field"]["field_format"]
			# se for um campo existente, não traz o type. Vou ter que buscar por params["custom_field"]["cf_id"]

			fc = {}
			init_conditions

			# if params.has_key?("custom_field") || params.has_key?("custom_table")

				if not params["custom_field"]["cf_id"].empty?
					if not params.has_key?("custom_table")
						@custom_field = CustomField.find(params["custom_field"]["cf_id"])
					else
						@custom_field = CustomTable.find(params["custom_field"]["cf_id"])
					end
				else
					if not params.has_key?("custom_table")
						@custom_field = CustomField.new
						@custom_field.safe_attributes = params["custom_field"]
					else
						@custom_field = CustomTable.new
						@custom_field.safe_attributes = params["custom_table"]
					end
				end

				fc = params["custom_field"]["field_conditions"]
				@conditions = {
					"rules" => [],
					"enabled" => (params["custom_field"]["field_conditions"]["enabled"]== "1"),
					"expr" => params["custom_field"]["field_conditions"]["expr"]
				}
			# end

			
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

			# if params.has_key?("custom_field") || params.has_key?("custom_table")
				if not params.has_key?("custom_table")
					# format parameters to save CustomField attribute conditions
					params["custom_field"]["conditions"] = @conditions
				else
					params["custom_table"]["conditions"] = @conditions
				end
			# end

		end

		def init_conditions
			@conditions = {'rules' => [] }

			# return unless params.has_key?"custom_field"

			# fc = params["custom_field"]["field_conditions"]

			# @conditions = {
			# 	"rules" => [],
			# 	"enabled" => (params["custom_field"]["field_conditions"]["enabled"]== "1"),
			# 	"expr" => params["custom_field"]["field_conditions"]["expr"]
			# }

			# unless fc['rule_name'].nil?
			# 	fc['rule_name'].each_with_index do |name, i|
			# 		@conditions['rules'].push( {
			# 			"name" => name.parameterize,
			# 			"rule" => {
			# 				"name" => name,
			# 				"field" => fc["rule_field"][i],
			# 				"op" => fc["rule_op"][i],
			# 				"val" => fc["rule_val"][i],
			# 			}
			# 		})
			# 	end

			# 	# TODO: vou precisar disso ainda?
			# 	# if not params.has_key?("custom_table")
			# 	# 	# format parameters to save CustomField attribute conditions
			# 	# 	params["custom_field"]["conditions"] = @conditions
			# 	# else
			# 	# 	params["custom_table"]["conditions"] = @conditions
			# 	# end
			# end

		end

	end
end