class CreateExternalRequestLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :external_request_logs do |t|
      t.string :request_method
      t.string :request_headers
      t.string :request_url
      t.string :request_body

      t.string :response_headers
      t.integer :response_status
      t.string :response_body
      t.jsonb :metadata

      t.timestamps
    end
  end
end
