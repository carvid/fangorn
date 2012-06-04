class Department < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Department'
  protect_access_with :parent
end

class Employee < ActiveRecord::Base
  belongs_to :department
  protect_access_with :department
end

class Document < ActiveRecord::Base
  belongs_to :department
  protect_access_with :department
end
