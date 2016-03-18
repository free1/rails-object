module Admin::BaseHelper

  def i18n_model_name_by_string(model_name)
    I18n.t "activerecord.models.#{model_name.underscore.downcase}"
  end

  def i18n_model_name(collection)
    I18n.t "activerecord.models.#{collection.klass.to_s.underscore.downcase}"
  end

  def i18n_model_name_by_resource(resource)
    I18n.t "activerecord.models.#{resource.class.to_s.underscore.downcase}"
  end

  def i18n_attribute_name(collection, elem)
    I18n.t "activerecord.attributes.#{collection.klass.to_s.underscore.downcase}.#{elem}"
  end

  def i18n_attribute_name_by_resource(resource, elem)
    I18n.t "activerecord.attributes.#{resource.class.to_s.underscore.downcase}.#{elem}"
  end

end
