module ProjectsOperations

  extend ActiveSupport::Concern

  def all_projects
    Project.includes(:owner, :lab, :contributors).order('updated_at DESC')
  end

  def filter_by_lab(slug)
    Project.joins(:lab).where("labs.slug = ?", slug)
  end

  def filter_by_tag(tags)
    Project.joins(:tags).where(:tags => {:name => tags.split(',')})
  end

  def map_projects
    Project.joins(:collaborations).includes(:lab).references(:lab).collect { |p| hash_project(p) }
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
