module Rawnet
  class CleverFormBuilder < ActionView::Helpers::FormBuilder
    include Haml::Helpers if defined? Haml # for compatibility
    
    helpers = field_helpers +
      %w(date_select datetime_select time_select collection_select calendar_date_select) +
      %w(collection_select select country_select time_zone_select radios) -
      %w(label fields_for)
    
    helpers.each do |name|
      define_method name do |field, *args|
        options = args.detect {|argument| argument.is_a?(Hash)} || {}
        options[:field_type] = name

        build_shell(field, options) do
          super
        end
      end
    end

    def build_shell(field, options)
      @template.capture do
        return yield if options.delete(:inline)

        locals = {
          :label_text  => options.include?(:label) ? options.delete(:label) : field.to_s.titleize,
          :required    => options.delete(:required) || false,
          :field_type  => options.delete(:field_type),
          :field_name  => field.to_s,
          :description => options.delete(:description),
          :help        => options.delete(:help),
          :sub_field   => options.delete(:sub_field),
          :field_class => options.delete(:field_class),
          :object      => object,
          :object_name => object_name,
          :element     => yield
        }
         
        if has_errors_on?(field)
          locals.merge!(:error => error_message(field, options))
        end
          
        return @template.render :partial => 'forms/field', :locals => locals
      end
    end
    
    def buttons(&block)
      concat '<div class="buttons">', block.binding
      yield self
      concat '</div>', block.binding
    end
    
    private
  
    def error_message(field, options)
      if has_errors_on?(field)
        errors = object.errors.on(field)
        errors.is_a?(Array) ? errors.to_sentence : errors
      else
        ''
      end
    end
  
    def has_errors_on?(field)
      !(object.nil? || object.errors.on(field).blank?)
    end
  end
end