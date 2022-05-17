module RedmineFieldConditions
	module Patches
		module CustomTablePatch
			
			def self.included(base)
				base.extend(ClassMethods)
				base.send :prepend, InstanceMethods
				base.class_eval do
					store :conditions, accessors: [:rules, :expr], coder: JSON
					safe_attributes 'conditions'
				end
			end

			module InstanceMethods

				# Overrides CustomTable#showable?
				# Returns true if the Tables Conditions for exhibition are satisfied
			  def showable?(issue)
			    return true if User.current.admin?
			    # teste de condição:
			    rules = []
			    rules << ((issue.custom_value_for(89).value =~ /.*Tributária.*/) == 0)
			    rules << (self.id == 46 || self.is_form?)
			    Rails.logger.info "REGRAS TABELA: #{rules}"
			    rules.all?(true)
			  end

			end

			module ClassMethods

			end
			
		end
	end
end