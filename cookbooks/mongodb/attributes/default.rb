# Set up Zip directory
default['mongodb']['installer']['drive'] = 'E'
default['mongodb']['installer']['home'] = "#{node['mongodb']['installer']['drive']}:\\Installfiles"
default['mongodb']['installer']['zip']['name'] = 'mongodb.zip'
default['mongodb']['installer']['zip']['path'] = "#{node['mongodb']['installer']['home']}\\#{node['mongodb']['installer']['zip']['name']}"

# Set up Home Directory
default['mongodb']['home'] = "#{node['mongodb']['installer']['drive']}:\\Program Files\\MongoDB\\Server\\4.4"
default['mongodb']['bin']['dir'] = "#{node['mongodb']['home']}\\bin"
default['mongodb']['bin']['configfile'] = "#{node['mongodb']['bin']['dir']}\\mongod.conf"

# Set up Data Directory
default['mongodb']['data']['drive'] = 'G'
default['mongodb']['data']['dir'] = "#{node['mongodb']['data']['drive']}:\\MongoDB\\Server\\4.4\\data"

# Set up Log Directory
default['mongodb']['log']['drive'] = 'H'
default['mongodb']['log']['dir'] = "#{node['mongodb']['log']['drive']}:\\MongoDB\\Server\\4.4\\log"
default['mongodb']['log']['logfile'] = "#{node['mongodb']['log']['dir']}\\mongod.log"

# Configuration Variables
default['mongodb']['config']['ip'] = '127.0.0.1'
default['mongodb']['config']['port'] = '27017'
default['mongodb']['config']['replicasetname'] = 'rs0'
default['mongodb']['config']['servicename'] = 'mongodb'