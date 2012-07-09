module ApplicationHelper
  def my_new_session_path
  	new_<%= @model_name.underscore %>_session_path
  end
  def my_new_registration_path
  	new_<%= @model_name.underscore %>_registration_path
  end
  def my_destroy_session_path
  	destroy_<%= @model_name.underscore %>_session_path
  end
end