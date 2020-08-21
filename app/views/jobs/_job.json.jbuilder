json.extract! job, :id, :title, :description, :apply_url, :is_featured, :is_verified, :user_id, :min_salary, :max_salary, :country_code, :created_at, :updated_at
json.url job_url(job, format: :json)
