module ProjectsOperations

  extend ActiveSupport::Concern

  def all_projects
    Project.visible.includes(:owner, :lab, :contributors)
      .order('updated_at DESC')
  end

  def filter_by(params)
    if params[:slug]
      filter_by_lab(params[:slug])
    elsif params[:q]
      filter_by_tag(params[:q])
    end
  end

  def filter_by_lab(slug)
    Project.visible.joins(:lab).where("labs.slug = ?", slug)
  end

  def filter_by_tag(tags)
    Project.visible.joins(:tags).where(:tags => {:name => tags.split(',')})
  end

  def map_projects
    Project.visible.joins(:collaborations).includes(:lab)
      .where.not('labs.id' => nil).collect { |p| hash_project(p) }
  end

  def search_projects(query)
    Project.visible
      .where("title LIKE ?", "%#{query}%") | filter_by_lab(query) | filter_by_tag(query)
  end

  def hash_project(project)
    { id: project.id,
      title: project.title,
      name: project.lab.name,
      kind: project.lab.kind_name,
      latitude: project.lab.latitude,
      longitude: project.lab.longitude,
      lab: lab_serializer(project),
      author: author_serializer(project)
    }
  end

  def lab_serializer(project)
    if project.lab
      {
        name: project.lab.name,
        latitude: project.lab.latitude,
        longitude: project.lab.longitude,
        kind: project.lab.kind_name,
        _link: {
          :href => "/#{project.lab.slug}",
          :method => "GET",
          :rel => "lab"
        }
      }
    end
  end

  def author_serializer(project)
    {
      username: project.owner.username,
      latitude: project.owner.latitude,
      longitude: project.owner.longitude,
      _link: {
        :href => "/users/#{project.owner.id}",
        :method => "GET",
        :rel => "user"
      }
    }
  end
end
