#Reserbus Dashboard!

For install: 

- Install the gem from the command line. Make sure you have Ruby 1.9
```
$ gem install dashing
```
- Clone the repo 
```
$ git clone https://github.com/reserbus/reserbus_dashboard.git
```
- Change your directory to `reserbus_dashboard` and bundle gems
```
$ bundle
```
- Create `.env` file with mixpanel keys
```
MIXPANEL_API_KEY=....
MIXPANEL_API_SECRET=...
```
- Start the server!
```
$ dashing start
```
- Point your browser at [localhost:3030](http://localhost:3030) and have fun!

Check out http://shopify.github.com/dashing for more information.
