actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :message, :kind_of => String, :required => true
attribute :room, :kind_of => String, :required => true
attribute :token, :kind_of => String, :required => true

attribute :color, :kind_of => String, :default => "purple"
attribute :sent_from, :kind_of => String, :default => "AWS OpsWorks"