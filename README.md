# BASH DEPLOY
### Author: Jonathan Scott  @jonathandata1
[bash-deploy.gif](https://postimg.cc/F7xW4vLQ)
### CURRENT VERSION 1.0

###
> ### Never use sh or ./ to run a bash script again
### Never create another alias
### Create historical backups of your scripts
### Create historical backups of your binaries
### Launch your scripts from anywhere in your terminal

# Availability
- MacOS
- Linux Distro's

## MacOS
```
brew install shc
```
## Linux
```
sudo add-apt-repository ppa:neurobin/ppa
sudo apt update
sudo apt install shc
```
## Add this to your bash_profile or zshrc
```
export PATH="$HOME/The_Drive/bash_profile/production/bin:$PATH" >> ~/.bash_profile
```
```
export PATH="$HOME/The_Drive/bash_profile/production/bin:$PATH" >> ~/.zshrc
```
## Organize all of your bash scripts

### This script will create a directory here
```
$HOME/The_Drive/bash_profile/dev/scripts
```
### Make sure you put all your bash scripts in here, then you can run deploy.sh
### Every BASH script that is in this folder will be turned into a binary

### Example: goliad.sh will turn in to goliad
### You can now just type goliad anywhere in your terminal and Goliad VPN will launch



