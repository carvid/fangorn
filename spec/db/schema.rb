ActiveRecord::Schema.define(:version => 0) do

  create_table :departments, :force => true do |t|
    t.column :name, :string
    t.column :parent_id, :integer
    t.column :lft, :integer
    t.column :rgt, :integer
  end

  create_table :employees, :force => true do |t|
    t.column :name, :string
    t.column :department_id, :integer
  end

  create_table :documents, :force => true do |t|
    t.column :name, :string
    t.column :department_id, :integer
  end

end

