ActiveAdmin.register Order do
  permit_params :user_id, :address_id, :total_price, :status

  index do
    selectable_column
    id_column
    column :user
    column :address
    column :total_price
    column :status
    actions
  end

  filter :user
  filter :address
  filter :total_price
  filter :status, as: :select, collection: Order.statuses.keys

  form do |f|
    f.inputs do
      f.input :user
      f.input :address
      f.input :total_price
      f.input :status, as: :select, collection: Order.statuses.keys
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :address
      row :total_price
      row :status
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
