ActiveRecord::Schema.define do
  create_table :addresses, :force => true do |t|
    t.string   :name
    t.text     :address
    t.string   :city
    t.string   :state
    t.string   :postal_code
    t.string   :country
    t.timestamps null:false
  end
end

