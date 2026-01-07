class JobsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :require_superadmin, only: [:new, :create, :edit, :update, :destroy]
  before_action :edit_job, only: [:edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    # TODO: we have a Job.recent method to show only posts updated_at within the last 90 days
    @q = Job.all.ransack(params[:q])
    @jobs = @q.result.order(created_at: :desc).page(params[:page])

    @countries = Job.country_list_for Job.all # should be only active jobs, not all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])
  end

  # GET /jobs/new
  def new
    @job = current_user.jobs.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = current_user.jobs.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def edit_job
      @job = current_user.jobs.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description, :apply_url, :is_featured, :is_verified, :user_id, :min_salary, :max_salary, :country_code, :tag_list)
    end
end
