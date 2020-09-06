class CustomerMessage < Message
  scope :unprocessed, -> { where(status: 'new', deleted: false)}
  # Ex:- scope :active, -> {where(:active => true)}
end