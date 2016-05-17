module InstanceOps

  # Extract a hash that contains only the fields provided as attributes to this method.
  # If the name of the field matches a method, this method is used with priority over the field.
  # field/method names must be provided as symbols.
  # @returns a hash containing the result of a call to methods/fields
  def only_members(*fields)
    Hash[fields.map{ |f|
      if respond_to? f
        [f,send(f)]
      else
        [f,self[f]]
      end
    }]
  end

end