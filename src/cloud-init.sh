#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt install nginx -y
sudo systemctl enable --now nginx

echo "Hello Hello"
