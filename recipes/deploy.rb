node[:deploy].each do |application, deploy|
  Chef::Log.info("Sending HipChat deployment notification for #{application}")

  if deploy[:scm] && deploy[:deploying_user]
    scm = deploy[:scm]
    opsworks_user = deploy[:deploying_user].split('/')[1]
  else
    scm = nil
    opsworks_user = nil
  end

  if deploy[:hipchat_run_on]
    if deploy[:hipchat_run_on].to_s == '_all'
      perform_notification = true
    else
      perform_notification = deploy[:hipchat_run_on].include?(node['hostname'])
    end
  else
    perform_notification = false
  end

  if deploy[:hipchat_token] && deploy[:hipchat_room_id] && application && perform_notification && !scm.nil?
    stack_name = node['opsworks']['stack']['name']
    stack_id = node['opsworks']['stack']['id']

    # Build the message to send to HipChat.
    message = "<strong>"
    message << "#{opsworks_user} " if opsworks_user
    message << "successfully deployed #{application}.</strong><br />"
    message << "Stack: #{stack_name}<br />"
    message << "Instance: #{node['hostname']}<br />"
    message << "<a href=\"https://console.aws.amazon.com/opsworks/home?#/stack/#{stack_id}/deployments/#{node['opsworks']['deployment']}\">details &raquo;</a>"

    opsworks_hipchat_notification "post-deploy-notification" do
      room deploy[:hipchat_room_id]
      token deploy[:hipchat_token]
      message message
    end
  end
end
