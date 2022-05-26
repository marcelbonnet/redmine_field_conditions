# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
match '/redmine_field_conditions/edit', to:'redmine_field_conditions#edit_custom_field', via: [:get, :post, :put]
match '/redmine_field_conditions/add/blank', to:'redmine_field_conditions#add_blank_condition', via: [:get, :post, :put]
match '/redmine_field_conditions/remove/:rule', to:'redmine_field_conditions#remove_rule', via: [:get, :post, :put]