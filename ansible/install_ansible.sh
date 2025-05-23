#!/bin/bash

# Update the system
sudo yum update -y

# Install dependencies
sudo amazon-linux-extras enable ansible2
sudo yum install -y ansible

# Confirm installation
ansible --version

