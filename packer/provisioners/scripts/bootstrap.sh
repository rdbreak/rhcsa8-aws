#!/bin/bash
set -ex

# Add EPEL repository
sudo yum install -y epel-release 
sudo yum install -y ansible firewalld vim bash-completion htop tmux screen telnet tree wget curl git httpd