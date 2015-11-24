ActiveAdmin.register Tracking do
  permit_params :history, :ip_address, :user_email

  filter :user_email
  filter :ip_address

  config.clear_action_items!
  actions :all, :except => [:new, :edit]

  index do
    column :ip_address
    column :user_email
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :ip_address
      row :user_email
      row("History") { render partial: 'admin/trackings/tracking', locals: { field: tracking.history } }
    end
  end
end