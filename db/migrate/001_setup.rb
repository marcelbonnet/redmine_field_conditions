class Setup < ActiveRecord::Migration[5.0]
	def change
		add_column :custom_fields, :conditions, :text, null:true

		# If redmine_tables plugin is installed after redmine_field_conditions
		# then this migration should be run manually or an error will occour.
		if ActiveRecord::Base.connection.table_exists?(:custom_tables)
			say "redmine_tables plugin found!"
			add_column :custom_tables, :conditions, :text, null:true
		end
	end
end