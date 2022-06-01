module RedmineFieldConditions

	# TODO I'm considering remove these
	# safe operators
	#  '(',')','[',']' are harder to check because it is not mandatory to put space between them and the rest of the sentence.
	# SAFE_OP_LIST = ['true', 'false', 'and', 'or', '&&', '||', '!','not','?',':', '%', '+','-','/','*','**', '==','!=','>','<','>=','<=','<=>','===','^', '&','|', '~', '<<','>>']
	# HARDER_TO_CHECK_OPS = /\(|\)|\[|\]/

	# Compile the condtions and return the result from an expression
	# @params {Hash} c The conditions
	# @params {Issue} issue The Issue
	def check_condition(c, issue)
		return true if c.empty? or c['enabled'] == false
		expr = c["expr"]
		rules_names = c["expr"].gsub(/\W/, " ").split #.reject{|w| SAFE_OP_LIST.include?(w) }
		rules_names.each do |rule_name|
			next unless c["rules"].collect{|r| r['name'] }.include?(rule_name)
			rule = c["rules"].select{|rules| rules["name"] == rule_name }
			b = compile_for_class(rule, issue)
			expr.gsub!(rule_name, b.to_s)
		end

		# It's not working for some expressions and I think it would remove
		# usefull power from the admin.
		# prevents dangerous code injection
		# is_safe = expr.gsub(HARDER_TO_CHECK_OPS, '').split.all?{|w| SAFE_OP_LIST.include?(w) }
		# if is_safe
		# 	return (eval expr)
		# else
		# 	raise "Unsafe operators found in conditions."
		# end
		(eval expr)
	end

	private

  # Compile the comparison
  # @params {Ojbect} v1 value
	# @params {String} op Operator: regex, eq, ne, lt, gt, le, ge
  # @params {Ojbect} v2 value
  def compile_for_operator(v1, op, v2)
  	# ignore the rule if the field does not exist for the issue
  	return true if v1.nil? || (v2.nil? && eval_value2?(op))

	  case op
	  when "regex"
	  		not v1.match(Regexp.new v2).nil?
	  when "eq"
	  	v1 == v2
	  when "ne"
	  	v2 != v2
	  when "lt"
	  	v1 < v2
	  when "le"
	  	v1 <= v2
	  when "gt"
	  	v1 > v2
	  when "ge"
	  	v1 >= v2
	  when "getvalue"
	  	v1
	  else # error
	  	raise "Invalid operator for redmine_conditions."
	  end
  end

	# Override this method when you need to include a new type
	# for the compiler
	# @params {Hash} r A rule
	# @params {Issue} issue The Issue
	def compile_for_class(r, issue)
		class_name = nil
		value = nil
		value_2 = nil
		field = r.first["rule"]["field"]
		if Tracker::CORE_FIELDS.include?(field)
			value = issue.send(field)
			class_name = value.class.name.downcase
		else
			cv = issue.custom_value_for(field)
			unless cv.nil?
				value = cv.value
				class_name = cv.custom_field.field_format.downcase
			end
		end

		# must implement Ruby types and Redmine::FieldFormat.available_formats
		case class_name
		when "int" || "integer" || "float"
			value = value.to_f
			value_2 = r[0]["rule"]["val"].to_f if eval_value2?(r[0]["rule"]["op"])
		when "date"
			v = r[0]["rule"]["val"]
			# trying to process ActiveSupport::Duration without directly eval
			# any unkown code
			if eval_value2?(r[0]["rule"]["op"])
				unless v.match(/[0-9]*[\. ][a-z]+/).nil?
					dur = eval v.split[0..1].join('.')
					value_2 = dur.ago
				else
					value_2 = User.current.format_time(v)
				end
			end
		# when "link"
		# when "list"
		# when "bool"
		# when "enumeration"
		# when "user"
		# when "version"
		# when "attachment"
		# ####################################################
		# TODO: move the next code to their plugins as 
		# a Patch to redmine_field_conditions
		# ####################################################
		when "fiscaliza"
			value = JSON.parse(value)["texto"]
			value_2 = r[0]["rule"]["val"] if eval_value2?(r[0]["rule"]["op"])
		# when "latlong"
			# 
			# value = JSON.parse(value.gsub("=>",":"))
		when "sei"
			value = JSON.parse(value.gsub("=>",":"))["numero"]
			value_2 = r[0]["rule"]["val"] if eval_value2?(r[0]["rule"]["op"])
		# ####################################################
		# Unknown types or String
		# ####################################################
		else # "string" or "text" fields
			value_2 = r[0]["rule"]["val"] if eval_value2?(r[0]["rule"]["op"])
		end
		
		compile_for_operator(value, r[0]["rule"]["op"], value_2)
	end

	def eval_value2?(op)
		case op
		when "getvalue"
			false
		else
			true
		end
	end

end