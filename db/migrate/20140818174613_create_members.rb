class CreateMembers < ActiveRecord::Migration
    def change
        create_table :members do |t|

            t.string "name"
            t.string "ieee_number"
            t.string "email"

            t.timestamps
        end
    end
end
