# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
match '/redmine_field_conditions', to:'redmine_field_conditions#edit_custom_field', via: [:get, :post, :put]