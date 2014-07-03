package "python-pip"

execute "install python hipchat module" do
  action :run
  command "pip install python-simple-hipchat"
end
