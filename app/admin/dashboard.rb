ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Users" do
          ul do
            User.last(25).map do |item|
              li link_to(item.full_name, admin_user_path(item))
            end
          end
        end
      end

      column do
        panel "Recent Labs" do
          Lab.last(25).map do |item|
            li link_to(item.name, admin_lab_path(item))
          end
        end
      end

      column do
        panel "Recent Jobs" do
          ul do
            Job.last(25).map do |item|
              li link_to(item.title, admin_job_path(item))
            end
          end
        end
      end
    end
  end # content
end
