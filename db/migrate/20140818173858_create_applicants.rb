class CreateApplicants < ActiveRecord::Migration
    def change
        create_table :applicants do |t|
            t.string "name"
            t.string "email"
            t.string "contact"
            t.string "sig"
            t.integer "date"
            t.datetime "dob"
            t.text "interests"
            t.string "ieee_number"
            t.timestamps
        end
    end
end
