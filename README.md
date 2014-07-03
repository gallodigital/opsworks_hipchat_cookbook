# HipChat OpsWorks Notifications

## Description

The *opsworks_hipchat* cookbook will automatically send [HipChat](http://www.hipchat.com)
notifications to your HipChat rooms.

## Requirements

- Amazon OpsWorks
- Custom Chef cookbooks enabled 
- Deployments should be performed by IAM users.

## Installation 

Note: This cookbook can be added to a Berksfile, so that is probably the best way to utilize this cookbook.

After finding a home for the cookbook:

1. put the "opsworks_hipchat" recipe in the layers you want deployment notifications for under the "Setup" section
2. put the "opsworks_hipchat::deploy" recipe in the "Deploy" section for the layers you added the above recipe
3. create 3 additional sections in your node[:deploy][:application_name] stack settings JSON, that will have your HipChat API key,
  room ID and OpsWorks instance (server) that will send the notification (or _all if you want notified after all instances deploy)

## Example

```json
{
    "deploy": {
        "my_fancy_app": {
            "hipchat_token" : "69d2627efe8f564c1cc0b6341e3291",
            "hipchat_room_id": "206231",
            "hipchat_run_on" : "rails-app1",
        }
}
```

## LWRPs

This cookbook also adds an `opsworks_hipchat_notification` LWRP so you can send notifications in other cookbooks.
The `message`, `room`, and `token` attributes are absolutely required; the rest have decent defaults.