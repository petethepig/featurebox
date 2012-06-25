module FeatureBox
  module ApplicationHelper
    
    def generate_form_element form, name, element
      if name == nil then 
        raw '<div class="control-group"><div class="controls">'+element+'</div></div>'
      else
        raw '<div class="control-group">'+form.label(name, :class=>"control-label")+'<div class="controls">'+element+'</div></div>'
      end
    end

    def multiline text
      raw h(text).gsub(/\n/, '<br/>')
    end

    
    def devise_error_messages_any?
      if respond_to? :resource
        return !resource.errors.empty?
      else 
        return false
      end
    end

    def devise_error_messages!
      resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join.html_safe
    end

    def devise_router_name
      send(FeatureBox::Settings.devise_router_name)
    end
  end
end