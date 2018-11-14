# FCM Tester
Very simple app that tests sending fcm push notifications.

# Prereq
1.  Ruby 2.5.3
2.  Bundler 1.17.1

# Instructions
1.  Get Source
```
git clone git@github.com:jkeam/fcm_tester.git
```

2.  Install Gems
```
bundle install
```

3.  Create `.env` file
```
# contents of env file will look like this
FCM_KEY=your_fcm_key_here
DEVICE_TOKEN=get_this_device_token_from_your_specific_device
```

4.  Run
```
./run.sh
```
