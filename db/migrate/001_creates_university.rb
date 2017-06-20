class CreatesUniversity < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|
      t.string :name, null:false
      t.string :code, null:false
    end

		create_table :courses do |t|
			t.string :name, null:false
			t.text :description, limit:10000, null:false
			t.references :program, foreign_key: true, null:false, index:true
		end

		create_table :grades do |t|
			t.float :grade, null:false
			t.references :course, foreign_key:true, null:false
			t.references :student, foreign_key:true, null:false
		end

		create_table :students do |t|
			t.string :login, null:false
			t.string :password, null:false
			t.string :name, null:false
			t.integer :age, null:false
			t.string :region, null:false
			t.string :email, null:false
			t.string :phone, null:false
			t.references :program, foreing_key:true, null:false
		end
  end
end
