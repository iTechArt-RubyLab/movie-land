module Users
  class Guest
    GUEST_USER_PERMISSIONS = %w[can_read_movie? can_read_person?].freeze

    def method_missing(name, *args, &block)
      return true if GUEST_USER_PERMISSIONS.include?(name.to_s)

      return false if name.to_s.start_with?('can')

      super(name, *args, &block)
    end

    def respond_to_missing?(name, include_private)
      return true if name.to_s.start_with?('can')

      super(name, include_private)
    end
  end
end
