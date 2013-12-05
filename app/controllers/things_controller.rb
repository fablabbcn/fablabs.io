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
      :inventory_item
    )]
  end
end
