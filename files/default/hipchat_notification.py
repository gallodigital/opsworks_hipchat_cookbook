#!/usr/bin/env python
import hipchat
import sys

token=sys.argv[1]
room=sys.argv[2]
sent_from=sys.argv[3]
application=sys.argv[4]
user=sys.argv[5]
stack_name=sys.argv[6]
stack_id=sys.argv[7]

message="Application %s deployed to %s by %s (<a href=\"https://console.aws.amazon.com/opsworks/home?#/stack/%s/deployments\">Details</a>)" % (application, stack_name, user, stack_id)
hipster = hipchat.HipChat(token=token)
# hipster.message_room(room, 'Amazon Opsworks', message, color='purple')
hipster.method('rooms/message', method='POST', parameters={
  'room_id': room,
  'from': sent_from,
  'message': message,
  'message_format': 'html',
  'color': 'purple'
})
