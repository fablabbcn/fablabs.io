namespace :discourse do
  desc 'Sync all labs with discourse'
  task sync_labs: :environment do
    Lab.find_each do |lab|
      lab.async_discourse_sync
    end
  end

  desc 'Sync all machines with discourse'
  task sync_machines: :environment do
    Machine.find_each do |machine|
      machine.async_discourse_sync
    end
  end

  desc 'Sync all projects with discourse'
  task sync_projects: :environment do
    Project.find_each do |project|
      project.async_discourse_sync
    end
  end

  desc 'Import from disqus'
  task discus_import: :environment do
    client = DiscourseService::Client.instance

    file = File.open('discus.xml')
    hash = Hash.from_xml(file.read)

    thread_ids = hash["disqus"]["post"].map{|x| x["thread"]["dsq:id"]}.uniq
    threads = hash["disqus"]["thread"].select{|x| thread_ids.include?(x["dsq:id"])}

    thread_id_discourse_id = {}
    threads.each do |thread|
      link = thread['link']
      if (match = link.match(/fablabs.io\/projects\/(\d+)/))
        project_id = match[1]
        item = Project.find_by(id: project_id)
      elsif (match = link.match(/fablabs.io\/machines\/(\d+)/))
        machine_id = match[1]
        item = Machine.find_by(id: machine_id)
      elsif (match = link.match(/fablabs.io\/([0-9a-z]+)$/))
        slug = match[1]
        item = Lab.find_by(slug: slug)
      end

      if item.present?
        thread_id = thread['dsq:id']
        thread_id_discourse_id[thread_id] = item.discourse_id
      end
    end

    p thread_id_discourse_id

    hash['disqus']['post'].reverse.each do |post|
      raw = "Posted by #{post["author"]["name"]} with the old comment system:<br/>"
      raw << post["message"]
      topic_id = thread_id_discourse_id[post["thread"]["dsq:id"]]

      if topic_id.present?
        begin
          p client.create_topic(topic_id: topic_id, raw: raw)
        rescue => e
          p e
        end
      end
    end
  end
end
