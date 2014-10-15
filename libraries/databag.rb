module SPRpe

  # set node attributes from a databag
  #
  # @param [String] rootitem
  # @param [String] name of the databag
  # @param [String] name of the bag
  # @param [String] optional environment
  def set_databag(rootitem, databag, bagname, environment=nil)
	begin
	    configuration = data_bag_item(databag, bagname)
            configuration = configuration[environment] if environment
            set_from_hash(node.default[rootitem], configuration)
        rescue
            Chef::Application.fatal!('Something was wrong while processing data_bag!', 1)
        end
  end

  # return clone a hash
  #
  # @param [hash] dst
  # @param [Hash] orig
  def set_from_hash(dst, hash)
       hash.each do |key, value|
           if not value.is_a?(Hash)
               dst[key] = value
           else
               set_from_hash(dst[key], value)
           end
       end
  end

end

