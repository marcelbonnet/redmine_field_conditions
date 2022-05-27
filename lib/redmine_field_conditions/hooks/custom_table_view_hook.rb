module RedmineFieldConditions
  module Hooks
    class CustomTableConditionsViewHook < Redmine::Hook::ViewListener
      render_on :view_custom_tables_form_upper_box, partial: 'custom_fields/hooks/fields_conditions'
    end
  end
end