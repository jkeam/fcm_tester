require 'fcm'
require 'dotenv'
Dotenv.load

def blank?(str)
  str.nil? || str.empty?
end

def load_env_vars(env)
  # load necessary env variables
  fcm_key = env['FCM_KEY'].freeze
  device_token = env['DEVICE_TOKEN'].freeze

  missing_key = blank?(fcm_key)
  missing_device_token = blank?(device_token)

  fields = nil
  if missing_key && missing_device_token
    fields = 'FCM_KEY and DEVICE_TOKEN'
  elsif missing_key
    fields = 'FCM_KEY'
  elsif missing_device_token
    fields = 'DEVICE_TOKEN'
  end

  {
    error: missing_key || missing_device_token,
    reason: "Missing #{fields} from .env",
    fcm_key: fcm_key,
    device_token: device_token
  }
end

def send_to_android(fcm, opts={title: nil, body: nil, data: nil, token: nil})
  return {error: true, reason: 'Missing token'} if blank?(opts[:token])
  options = {
    notification: {
      title: opts[:title] || '',
      text: opts[:body] || ''
    },
    data: opts[:data] || {}
  }
  fcm.send_notification [opts[:token]], options
end

# main
envs = load_env_vars ENV
if envs[:error]
  puts envs[:reason]
  exit
end
FCM_KEY, DEVICE_TOKEN = envs.values_at :fcm_key, :device_token

fcm = FCM.new FCM_KEY
message = {
  title: 'Test',
  body: 'This is a test message',
  token: DEVICE_TOKEN
}
puts JSON.pretty_generate(send_to_android(fcm, message))
