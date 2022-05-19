module RedmineFieldConditionsHelper

	OPERATORS = [
		['=~', 'regex'],
		['=', 'eq'],
		['!=', 'ne'],
		['>', 'gt'],
		['>=', 'ge'],
		['<', 'lt'],
		['<=', 'le']
	]

	def build_conditions_form(custom_field, rules)
		html = ""
		
		elements = label_tag( l("redmine_field_conditions.label_rule_name"))
		elements << text_field_tag( "custom_field[field_conditions][rule_name][]", (rules.nil? ? "" : rules['rule']['name']), maxlength:30)
		html << content_tag(:p, elements)
		
		core_fields = Tracker::CORE_FIELDS
		unless custom_field.id.nil?
			core_fields = custom_field.trackers.map{|t| t.core_fields}.uniq.sort.flatten
		end
		selected_field = (rules.nil? ? "" : rules['rule']['field'])

		elements = label_tag( l("redmine_field_conditions.label_rule_field"))
		elements << select_tag("custom_field[field_conditions][rule_field][]", options_for_select(core_fields, selected_field) + options_from_collection_for_select(CustomField.where(type: custom_field.type).order(:name), "id", "name", selected_field))
		html << content_tag(:p, elements)
		
		elements = label_tag( l("redmine_field_conditions.label_rule_op"))
		elements << select_tag("custom_field[field_conditions][rule_op][]", options_for_select(OPERATORS, (rules.nil? ? "" : rules['rule']['op'])))
		html << content_tag(:p, elements)
		
		elements = label_tag( l("redmine_field_conditions.label_rule_val"))
		elements << text_field_tag( "custom_field[field_conditions][rule_val][]", (rules.nil? ? "" : rules['rule']['val']))
		html << content_tag(:p, elements)

		html.html_safe
	end

end