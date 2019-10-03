class Backstage::RedirectsController < Backstage::BackstageController

  def projects
    redirect_to 'https://projects.fablabs.io', status: 302
  end

  def myprojects
    redirect_to 'https://projects.fablabs.io', status: 302
  end
end