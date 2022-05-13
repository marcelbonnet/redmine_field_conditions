module RedmineFieldConditions
  module Hooks
    class ConditionsViewHook < Redmine::Hook::ViewListener
      render_on :view_custom_fields_form_upper_box, partial: 'custom_fields/hooks/fields_conditions'
    end
  end
end