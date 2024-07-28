ActiveAdmin.register Order do
  permit_params :user_id, :address_id, :status, :gst_rate, :pst_rate, :hst_rate, order_items_attributes: [:id, :product_id, :quantity, :unit_price, :_destroy]

  index do
    selectable_column
    id_column
    column :user
    column :address
    column :total_price
    column :gst_rate
    column :pst_rate
    column :hst_rate
    column :tax_amount
    column :grand_total
    column :status
    column "Products" do |order|
      order.order_items.map { |item| item.product.name }.join(", ")
    end
    actions
  end

  filter :user
  filter :address
  filter :total_price
  filter :gst_rate
  filter :pst_rate
  filter :hst_rate
  filter :status, as: :select, collection: Order.statuses.keys

  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.all.map { |user| [user.email, user.id] }
      f.input :address, as: :select, collection: Address.all.map { |address| ["#{address.street}, #{address.city}, #{address.province.name}, #{address.postal_code}", address.id] }
      f.input :gst_rate
      f.input :pst_rate
      f.input :hst_rate
      f.input :status, as: :select, collection: Order.statuses.keys
      f.has_many :order_items, allow_destroy: true, new_record: true do |oi|
        oi.input :product
        oi.input :quantity
        oi.input :unit_price
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :address
      row :total_price
      row :gst_rate
      row :pst_rate
      row :hst_rate
      row :tax_amount
      row :grand_total
      row :status
    end
    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :unit_price
        column :total_price
      end
    end
    active_admin_comments
  end

  member_action :mark_as_paid, method: :put do
    order = Order.find(params[:id])
    order.update(status: :paid)
    redirect_to admin_order_path(order), notice: "Order marked as paid!"
  end

  member_action :mark_as_shipped, method: :put do
    order = Order.find(params[:id])
    order.update(status: :shipped)
    redirect_to admin_order_path(order), notice: "Order marked as shipped!"
  end

  action_item :mark_as_paid, only: :show, if: proc { resource.unpaid? } do
    link_to "Mark as Paid", mark_as_paid_admin_order_path(resource), method: :put
  end

  action_item :mark_as_shipped, only: :show, if: proc { resource.paid? } do
    link_to "Mark as Shipped", mark_as_shipped_admin_order_path(resource), method: :put
  end
end
