module RedmineFieldConditions
  module Hooks
    class ConditionsHook < Redmine::Hook::Listener
      def after_plugins_loaded(context={})
        # redmine_tables plugin patch
        begin
          CustomTable.is_a?(Class)
          puts "redmine_field_conditions found redmine_tables. Applying patch..."
        rescue NameError
        end

        # redmine_forms plugin patch
        # begin
        #   CustomTable.is_a?(Class)
        #   puts "redmine_field_conditions found redmine_forms. Applying patch..."
        # rescue NameError
        # end

      end
    end
  end
end