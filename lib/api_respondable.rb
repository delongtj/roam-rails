module ApiRespondable
  extend ActiveSupport::Concern

  included do
    acts_as_paranoid
  end

  def is_column_datetime?(column_name)
    self.class.columns.find { |c| c.name == column_name }.try(:type) == :datetime
  end

  # Override for all objects returned by the API
  def as_json(*args)
    response = {}

    attributes.except('deleted_at').each do |k, v|
      if is_column_datetime?(k)
        response[k] = v.to_s
      else
        response[k] = v
      end
    end

    response
  end
end
