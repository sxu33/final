ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  remove_filter :carts
  remove_filter :cart_items
  remove_filter :image_attachment
  remove_filter :image_blob
  permit_params :name, :description, :price, :category_id, :on_sale, :new, :recently_updated, :image, cart_items:[:id, :cart_id, :product_id, :quantity, :destroy]
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :category_id, :on_sale, :new, :recently_updated]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end
  
end
