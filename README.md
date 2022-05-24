Redmine Field Conditions
------------------------

Under development.

Adds rules so a CustomField is shown/editable/required dinamically depending on defined rules.

When more than one rule is defined, an expression is allowed. Conceptually:

```
	( contains_string_foo AND start_date_up_to_last_week ) OR custom_field_bar_major_than_five
```

Another example: a custom field value is shown only if the current Issue was started up to 7 days ago.


Redmine Tables Plugin
---------------------

If redmine_tables plugin is installed after redmine_field_conditions then an migration should be run manually (rails console) to add the column _conditions_ to _custom_tables_. See db/migrate folder if needed.


Internals
---------

Conditions are saved as Hash, using ActiveRecord::Store.

Some checks are made to avoid dangerous code to be evaluated and so, some operators are included in a safe list.

Custom fields may demand implementation of additional code if they cannot be treated as Date, String, Integer, Float... or other types already coded.

The module _RedmineFieldConditions_ is responsible for compiling expressions and implementing different types. Third plugins may patch this module to add new types.

```
	expressions = {
		"rules"=> [
			{ 
				"name"=> "contains_string",
				"rule"=> {
					"name"=> "Contains String",
					"field"=> "89",
					"op"=> "regex",
					"val"=> ".*Street.*"
				}
			},
			{ 
				"name"=> "started_date",
				"rule"=> {
					"name"=> "Started Date",
					"field"=> "start_date",
					"op"=> "gt",
					"val"=> "180 days"
				}
			}
		],
		"expr"=> "(contains_string and started_date)",
		"enabled" => true
	}
```

Another example: the issue must have start_date >= 7.days.ago as condition for exhibition of the field:

```
	{
		"rules"=> [
			{ 
				"name"=> "started_date",
				"rule"=> {
					"name"=> "Started Date",
					"field"=> "start_date",
					"op"=> "gt",
					"val"=> "7 days"
				}
			}
		],
		"expr"=> "started_date",
		"enabled" => true
	}
```
TODO
----------

* Compare between custom fields/core fields