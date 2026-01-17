class Backstage::RedirectsController < Backstage::BackstageController

  def projects
    redirect_to 'https://projects.fablabs.io', allow_other_host: true, status: 302
  end

  def myprojects
    redirect_to 'https://projects.fablabs.io/@' + current_user.username, allow_other_host: true, status: 302
  end
end