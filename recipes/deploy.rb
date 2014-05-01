node[:deploy].each do |application, deploy|
  token = deploy[:hipchat_token]
  room = deploy[:hipchat_room_id]
  sent_from = deploy[:hipchat_notify_from] || 'Amazon OpsWorks'
  application_name = application
  if deploy[:scm] and deploy[:deploying_user]
    scm = deploy[:scm]
    opsworks_user = deploy[:deploying_user].split('/')[1]
  else
    scm = nil
    opsworks_user = nil
  end
  if deploy[:hipchat_run_on]
    perform_notification = deploy[:hipchat_run_on].include?(node['hostname'])
  else
    perform_notification = false
  end

  if token && room && application_name && perform_notification && !scm.nil? then
    stack_state = JSON.parse(`opsworks-agent-cli stack_state`)
    stack_name = stack_state['stack']['name']
    stack_id = stack_state['stack']['id']

    execute "send hipchat notification" do
      command "/usr/bin/hipchat_notification.py #{token} #{room} #{sent_from} #{application_name} #{opsworks_user} \"#{stack_name}\" #{stack_id}"
      action :run
    end
  end
end
