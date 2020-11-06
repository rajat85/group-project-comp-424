class CreateSecurityQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :security_questions do |t|
      t.string :locale, null: false
      t.string :name, null: false
      t.timestamps
    end
    add_column :the_resources, :security_question_id, :integer
    add_column :the_resources, :security_question_answer, :string
  end
end
