module Rawnet
  module CleverFormsHelper

    [:form_for, :fields_for, :form_remote_for, :remote_form_for].each do |meth|
      src = <<-end_src
        def clever_#{meth}(object_name, *args, &proc)
          options = args.last.is_a?(Hash) ? args.pop : {}
          options.update(:builder => Rawnet::CleverFormBuilder)
          #{meth}(object_name, *(args << options), &proc)
        end
      end_src
    
      module_eval src
    end
  
  end
end
