#
# Cookbook:: mongodb
# Recipe:: default
#

# Create Mongo Bin folder
directory node['mongodb']['home'] do
    action :create
    recursive true
end
  
# Create Data folder
directory node['mongodb']['data']['dir'] do
    action :create
    recursive true
end
  
# Create Log folder
directory node['mongodb']['log']['dir'] do
    action :create
    recursive true
end
    
# Extract the binary
windows_zipfile node['mongodb']['home'] do
    source node['mongodb']['installer']['zip']['path']
    action :unzip
    not_if { ::File.exist?(node['mongodb']['bin']['dir']) }
end
  
# Set Mongo directory into Env
windows_env 'MONGO_HOME' do
    value "#{node['mongodb']['home']}"
    action :create
end
  
# Set Mongo Bin directory into Path
windows_path "%MONGO_HOME%\\bin" do
    action :add
end
  
# Configure Mongod.conf
template "#{node['mongodb']['bin']['dir']}\\mongod.conf" do
    source 'mongod.conf.erb'
end
  
# Setup MongoDB Windows Service
powershell_script 'MongoDBService' do
    guard_interpreter :powershell_script
    code "mongod --config \"#{node['mongodb']['bin']['configfile']}\" --install"
end
  
# Start MongoDB service
windows_service 'MongoDB' do
     action :start
end
  
# Initialise the MongoDB RS
powershell_script 'MongoDbReplSet' do
    guard_interpreter :powershell_script
    code "mongo mongodb://#{node['mongodb']['config']['ip']}:#{node['mongodb']['config']['port']} --eval \"rs.initiate()\""
end
  