class Backstage::PagesController < Backstage::BackstageController

  before_action :require_admin

  def index
    @pages = Page.page(params[:page]).order('position asc')
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to [:edit, :backstage, @page], notice: 'Page created'
    else
      render :new
    end
  end

  def edit
    find_page
  end

  def update
    find_page
    if @page.update(page_params)
      redirect_to [:edit, :backstage, @page], notice: 'Page updated'
    else
      render :edit
    end
  end

  def destroy
    find_page
    @page.destroy
    redirect_to [:backstage, :pages], notice: 'Page deleted'
  end

  private

  def find_page
    @page = Page.friendly.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :content, :published, :position, :slug)
  end
end
