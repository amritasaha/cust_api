ActiveAdmin.register Post do


  member_action :approve, :method => :get do
    # Just a regular controller method in here
    post = Post.find params[:id]
    puts post.inspect
    redirect_to admin_post_path(post)
  end


  index do
    column :id
    column :title
    actions do |post|
      link_to 'Approve', approve_admin_post_path(post)
    end
  end




# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :description
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
