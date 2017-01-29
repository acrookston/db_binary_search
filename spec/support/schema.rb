ActiveRecord::Schema.define do
  self.verbose = false

  create_table :logs, :force => true do |t|
    t.timestamp :created_at
  end
end

