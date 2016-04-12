# Create the etc dir if needed
mkdir -p /usr/local/etc

# Create a simple configuration
# This forces the .dev domain to respond with 127.0.0.1
# You can find more information in the default config file:
#   /usr/local/opt/dnsmasq/dnsmasq.conf.example
echo "address=/.local/127.0.0.1" > /usr/local/etc/dnsmasq.conf

# Install the daemon startup file
sudo cp -fv /usr/local/opt/dnsmasq/*.plist /Library/LaunchDaemons

# Start the daemon
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

sudo mkdir -p /etc/resolver
sudo sh -c 'echo "nameserver 127.0.0.1" > /etc/resolver/local'
