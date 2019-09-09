module ApiRespondable
  extend ActiveSupport::Concern

  included do
    acts_as_paranoid
  end

  def is_date_column?(column_name)
    [ :datetime, :date ].include?(self.class.columns.find { |c| c.name == column_name }.try(:type))
  end

  # Override for all objects returned by the API
  def as_json(*args)
    response = {}

    attributes.except('deleted_at').each do |k, v|
      if is_date_column?(k)
        response[k] = v.to_s
      else
        response[k] = v
      end
    end

    response
  end
end
