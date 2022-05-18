module RedmineFieldConditions
	module Patches
		module CustomFieldPatch
			
			def self.included(base)
				base.extend(ClassMethods)
				base.send :prepend, InstanceMethods
				base.class_eval do
					include RedmineFieldConditions
					store :conditions, accessors: [:rules, :expr], coder: JSON
					safe_attributes 'conditions'
				end
			end

			module InstanceMethods

				# Check if the CustomField (probably a subclass) satisfies
				# the conditions to be shown
				# @params {Object} obj An Issue, Document, Project...
				def visible_to?(obj)
			    return true if User.current.admin?
			    case obj
			    when Issue
			    	return check_condition(self.conditions, obj)
			    else
			    	return true
			    end
			  end

			  def editable_to?(obj)
			  	# TODO
			  end

			  def required_to?(obj)
			  	# TODO
			  end

			  def multiple_to?(obj)
			  	# TODO
			  end
				
			end

			module ClassMethods

			end

		end
	end
end