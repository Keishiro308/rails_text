class AllowedSourcePresenter < ModelPresenter
  delegate :octet1, :octet2, :octet3, :octet4, :wildcard?, to: :object

  def ip_address
    [ octet1, octet2, octet3, wildcard? ? '*' : octet4 ].join('.')
  end

  def created_at
    object.created_at.try(:strftime, "%Y/%m/%d %H:%M:%S")
  end
  
end