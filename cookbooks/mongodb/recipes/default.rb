#
# Cookbook:: mongodb
# Recipe:: default
#

# Create Mongo Bin folder
directory "E:\\Program Files\\MongoDB\\Server\\4.4" do
    action :create
    recursive true
end
  
# Create Data folder
directory "G:\\MongoDB\\Server\\4.4\\data" do
    action :create
    recursive true
end
  
# Create Log folder
directory "H:\\MongoDB\\Server\\4.4\\log" do
    action :create
    recursive true
end
    
# Extract the binary
windows_zipfile "E:\\Program Files\\MongoDB\\Server\\4.4" do
    source "E:\\mongodb.zip" ## Zip contains the MongoDB Bin folder along with license + readme from official site.
    action :unzip
    not_if { ::File.exist?("E:\\Program Files\\MongoDB\\Server\\4.4\\bin") }
end
  
# Set Mongo directory into Env
windows_env 'MONGO_HOME' do
    value "E:\\Program Files\\MongoDB\\Server\\4.4"
    action :create
end
  
# Set Mongo Bin directory into Path
windows_path "%MONGO_HOME%\\bin" do
    action :add
end
  
# Configure Mongod.conf
template "E:\\Program Files\\MongoDB\\Server\\4.4\\bin\\mongod.conf" do
    source 'mongod.conf.erb'
end
  
# Setup MongoDB Windows Service
powershell_script 'MongoDBService' do
    guard_interpreter :powershell_script
    code "mongod --config \"E:\\Program Files\\MongoDB\\Server\\4.4\\bin\\mongod.conf\" --install"
end
  
# Start MongoDB service
windows_service 'MongoDB' do
     action :start
end
  
# Initialise the MongoDB RS
   powershell_script 'MongoDbReplSet' do
    guard_interpreter :powershell_script
    code "mongo mongodb://127.0.0.1:27017 --eval \"rs.initiate()\""
end
  