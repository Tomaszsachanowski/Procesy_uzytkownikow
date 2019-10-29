#!/bin/bash

sudo useradd test1_user
sudo -u test1_user sleep 60 &
sudo -u test1_user sleep 60
sudo userdel test1_user

sleep 60
yes yes

