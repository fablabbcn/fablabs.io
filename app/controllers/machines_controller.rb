class MachinesController < ApplicationController
  include InheritedResourcesWithAuthority

  def build_resource_params
    [params.fetch(:machine, {}).permit(
      :name,
      :brand_id,
      :description,
      :parent_id,
      :photo_src
    )]
  end

end
