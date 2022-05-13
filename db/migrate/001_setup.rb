class Setup < ActiveRecord::Migration[5.0]
	def change
		add_column :custom_fields, :conditions, :text, null:true

		if ActiveRecord::Base.connection.table_exists?(:custom_tables)
			say "redmine_tables plugin found!"
			add_column :custom_tables, :conditions, :text, null:true
		end
	end
end