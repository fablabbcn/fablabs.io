class AddActivityStatusToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :activity_status, :string
    add_column :labs, :activity_start_at, :date
    add_column :labs, :activity_inaugurated_at, :date
    add_column :labs, :activity_closed_at, :date
    say_with_time "migrate existing data" do
      Lab.find_each do |lab|
        if lab.kind == 0
          lab.update_column(:kind, 2)
          lab.update_column(:activity_status, 'planned')
        else
          lab.update_column(:kind, lab.kind - 1)
        end
      end
    end
  end
end
