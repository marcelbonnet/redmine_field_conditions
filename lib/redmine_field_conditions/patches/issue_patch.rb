module RedmineFieldConditions
	module Patches
		module IssuePatch
			
			def self.included(base)
				base.extend(ClassMethods)
				base.send :prepend, InstanceMethods
				base.class_eval do
				end
			end

			module InstanceMethods

				# TODO IssuePatch: properly override Issue methods from acts_as_customizable
				# TODO patch the same methods in Redmine::Acts::Customizable in another patch file.
				# TODO other objects must receive patches to check conditions for show/edit/required custom field values (patching Document, Project ...)
				
				# Prepends Issue#visible_custom_field_values
				def visible_custom_field_values(user=nil)
			    custom_field_values = super(user)
			    return custom_field_values if User.current.admin?

			    custom_field_values.select do |cfv|
			    	cfv.custom_field.visible_to?(self)
			    end
			  end

			  def editable_custom_field_values(user=nil)
			  	# TODO
			  	super(user)
			  end

			  def required_attribute_names(user=nil)
			  	# TODO
			  	super(user)
			  end

			end

			module ClassMethods

			end

		end
	end
end