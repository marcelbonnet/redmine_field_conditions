require 'redmine_field_conditions'

Redmine::Plugin.register :redmine_field_conditions do
  name 'Redmine Field Conditions'
  author 'Marcel Bonnet'
  description 'Adds conditions for custom fields to dynamically change rules for its exhibition or filling requirement.'
  version '0.0.5'
  url 'https://github.com/marcelbonnet/redmine_field_conditions'
  author_url 'https://github.com/marcelbonnet'

  requires_redmine :version_or_higher => '4.0.0'

end

require_dependency 'redmine_field_conditions/hooks/custom_table_hook'
require_dependency 'redmine_field_conditions/hooks/custom_table_view_hook'
require_dependency 'redmine_field_conditions/hooks/custom_field_view_hook'

Rails.configuration.to_prepare do
  CustomField.send :include, RedmineFieldConditions::Patches::CustomFieldPatch
  CustomFieldsHelper.send :include, RedmineFieldConditions::Patches::CustomFieldsHelperPatch
  Issue.send :include, RedmineFieldConditions::Patches::IssuePatch
end

# ########################################################
# Esse lixo todo abaixo é pra me lembrar de patches que
# devem ser feitos

# Dir[File.join(File.dirname(__FILE__), '/lib/patches/**/*.rb')].each { |file| require_dependency file }
# require_dependency 'hooks.rb'

# # these hooks are alphabetically loaded
# class ZzzHook < Redmine::Hook::Listener
#   def after_plugins_loaded(context = {})
#     begin
#       Module.const_get("CustomTable").is_a?(Class)
#       CustomEntity.send :include, RedmineForms::CustomEntityPatch
#     rescue NameError
#       raise Redmine::PluginNotFound, "Missing dependency. You need to install redmine_tables plugin from https://github.com/marcelbonnet/redmine_tables."
#     end
#   end
# end

# atualizar a página: tem um controller

# CustomFieldPatch
# safe_attributes
# is_required, is_... são atalhos. Mas preciso de patches para o Core existente:

# Patches no Core que processa as views:
# ver se é o caso para de fazer patches para:
# def required_attribute_names  # => Issue

# /home/marcelbonnet/VirtualBox/vagrant/fiscaliza421/app/models/issue.rb:
#   624  
#   625    # Returns the custom_field_values that can be edited by the given user
#   626:   def editable_custom_field_values(user=nil)
#   627      read_only = read_only_attribute_names(user)
#   628      visible_custom_field_values(user).reject do |value|

# /home/marcelbonnet/VirtualBox/vagrant/fiscaliza421/app/models/project.rb:
#   970  
#   971    # Returns the custom_field_values that can be edited by the given user
#   972:   def editable_custom_field_values(user=nil)
#   973      visible_custom_field_values(user)
#   974    end

# /home/marcelbonnet/VirtualBox/vagrant/fiscaliza421/app/models/time_entry.rb:
#   206  
#   207    # Returns the custom_field_values that can be edited by the given user
#   208:   def editable_custom_field_values(user=nil)
#   209      visible_custom_field_values(user)
#   210    end

# /home/marcelbonnet/VirtualBox/vagrant/fiscaliza421/app/models/version.rb:
#   192  
#   193    # Returns the custom_field_values that can be edited by the given user
#   194:   def editable_custom_field_values(user=nil)
#   195      visible_custom_field_values(user)
#   196    end

# 
# /home/marcelbonnet/VirtualBox/vagrant/fiscaliza421/app/models/issue.rb:
#   266    end
#   267  
#   268:   def visible_custom_field_values(user=nil)
#   269      user_real = user || User.current
#   270      custom_field_values.select do |value|

# /home/marcelbonnet/VirtualBox/vagrant/fiscaliza421/app/models/project.rb:
#   974    end
#   975  
#   976:   def visible_custom_field_values(user = nil)
#   977      user ||= User.current
#   978      custom_field_values.select do |value|

# /home/marcelbonnet/VirtualBox/vagrant/fiscaliza421/app/models/time_entry.rb:
#   215    end
#   216  
#   217:   def visible_custom_field_values(user = nil)
#   218      user ||= User.current
#   219      custom_field_values.select do |value|

# /home/marcelbonnet/VirtualBox/vagrant/fiscaliza421/app/models/version.rb:
#   196    end
#   197  
#   198:   def visible_custom_field_values(user = nil)
#   199      user ||= User.current
#   200      custom_field_values.select do |value|

# /home/marcelbonnet/VirtualBox/vagrant/fiscaliza421/lib/plugins/acts_as_customizable/lib/acts_as_customizable.rb:
#    99          end
#   100  
#   101:         def visible_custom_field_values
#   102            custom_field_values.select(&:visible?)
#   103          end