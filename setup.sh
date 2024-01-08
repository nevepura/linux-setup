#!/bin/bash
# Launch this as super user right after you have installed linux.

if [ $(whoami) != "root" ]
then
    echo "Become super user before launching the script. Exiting early."
    exit 1
fi

apt update

echo 'Installing programs...'

# chrome
echo 'Installing Chrome...'
CHROME=latest-chrome.deb
wget -O $CHROME https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i $CHROME
rm $CHROME

# git
echo 'Installing Git...'
apt install git

# git configuration
git config --global user.name "nevepura"

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.cim "commit -m"
git config --global alias.st status

$SSH_AGENT_FILE="github-ssh-agent-config.txt"
if [ -e "$SSH_AGENT_FILE" ]
then
    cat "$SSH_AGENT_FILE" >> $HOME/.profile
fi


# printer drivers
echo "Installing printer drivers"
$PRINTER=printer-driver.deb
wget -O $PRINTER http://download.ebz.epson.net/dsc/op/stable/RPMS/x86_64/epson-inkjet-printer-stylus-nx110-series-1.0.0-1lsb3.2.x86_64.rpm
dkpg -i $PRINTER
# Missing dependencies can occur prevent the installation to complete. Fix them then retry...
apt install -f -y
dpkg -i $PRINTER

echo 'Done.'

