windows_task 'Post-Restart-Task' do
    user 'SYSTEM'
    command 'cmd.exe /c chef-solo --chef-license=accept -c C:\Chef\solo.rb -o "recipe[powershell::default]" > C:\Chef\Logs\task.txt'
    description "This is a task created to resume the task once reboot complete."
    run_level :highest
    frequency :onstart
    action :create
end

reboot 'app_reboot' do
    action :request_reboot
    reason 'Reboot after Installation'
end