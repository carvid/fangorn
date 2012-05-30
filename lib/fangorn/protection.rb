require 'fangorn/exceptions'

module Fangorn

  module Protection
    extend ActiveSupport::Concern

    module ClassMethods

      def protect_access_with(association_symbol)

        # Filter all records that can't be accessed for the model instance passed.
        #
        # ==== Examples
        #
        #   Course.accesible(current_user)
        #   #=> all courses accessible for the current user.
        #
        scope :accessible, lambda { |accessor|

          protector = reflect_on_association(association_symbol)

          level = if accessor.class == protector.klass
            accessor
          else
            association = accessor.class.reflect_on_all_associations.detect do |assoc|
              assoc.klass == protector.klass
            end
            accessor.send(association.name)
          end

          query = where("#{protector.table_name}.lft" => (level.lft..level.rgt))
          query = query.joins(protector.name) unless protector.klass == scoped.klass
          query
        }

        define_method :access_protector do
          @access_protector ||= begin
            association = self.class.reflect_on_association(association_symbol)
            protector = if self.class == association.klass
              self
            else
              send(association.name)
            end
            protector
          end
        end

        # Returns true if a record can be accessed for the passed model instance.
        # It receives an instance of ActiveRecord model and check if that model can
        # access the actual record. It looks in all model's associations for one
        # of the same class that the association which protects the record.
        #
        define_method :accessible? do |accessor|
          level = if access_protector.class == accessor.class
            accessor
          else
            association = accessor.class.reflect_on_all_associations.detect do |assoc|
              assoc.klass == access_protector.class
            end
            accessor.send(association.name)
          end
          access_protector.lft.between?(level.lft, level.rgt)
        end

        define_method :accessible! do |model|
          raise Fangorn::RecordNotAccessible,
            'record not accessible' unless accessible?(model)
          self
        end

      end

    end

  end

end

# Move this to the proper initializer in Rails::Engine extended class when
# make it a gem.
ActiveSupport.on_load(:active_record) do
  include Fangorn::Protection
end

