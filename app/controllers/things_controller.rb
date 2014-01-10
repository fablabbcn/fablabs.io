class ThingsController < ApplicationController
  include InheritedResourcesWithAuthority

  def build_resource_params
    [params.fetch(resource_class.name.parameterize.to_sym, {}).permit(
      :name,
      :brand_id,
      :description,
      :parent_id,
      :photo_src,
      :tag_list,
      :inventory_item,
      links_attributes: [ :id, :link_id, :description, :url, '_destroy' ],
    )]
  end
end
