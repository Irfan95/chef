powershell_script 'initial-setup' do
    code <<-EOH
    Get-Service | Out-File C:\Test.txt 
    EOH
end

windows_task 'Post-Restart-Task' do
    action :delete
    only_if { ::File.exist?('C:\\Test.txt') }
end