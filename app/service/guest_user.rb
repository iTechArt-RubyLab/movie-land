class GuestUser
  def guest?
    true
  end

  def method_missing(name, *args, &block)
    return false if name.to_s.start_with?('can')

    super(name, *args, &block)
  end

  def respond_to_missing?(name, include_private)
    return true if name.to_s.start_with?('can')

    super(name, include_private)
  end
end
