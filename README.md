
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# RabbitMQ User Account Lockout
---

This incident type refers to the situation when a user account in RabbitMQ messaging system is locked out and inaccessible. This could be caused by various reasons such as incorrect login attempts, system errors or security measures. The incident requires investigation to identify the root cause and unlock the affected accounts to restore proper functionality.

### Parameters
```shell
export USERNAME="PLACEHOLDER"

export NEW_PASSWORD="PLACEHOLDER"
```

## Debug

### 4. Check RabbitMQ user permissions
```shell
sudo rabbitmqctl list_user_permissions ${USERNAME}
```

### 5. Unlock RabbitMQ user account
```shell
sudo rabbitmqctl clear_password ${USERNAME}
```

### 1. Check RabbitMQ status
```shell
sudo systemctl status rabbitmq-server
```

### 2. Check RabbitMQ logs for errors
```shell
sudo journalctl -u rabbitmq-server | grep -i error
```

### 3. Check RabbitMQ user accounts
```shell
sudo rabbitmqctl list_users
```

## Repair

### Once the root cause has been identified, take steps to resolve the issue. For example, if the account was locked due to failed login attempts, reset the password or investigate any potential security breaches.
```shell


#!/bin/bash



# Set variables

USERNAME=${USERNAME}

NEW_PASSWORD=${NEW_PASSWORD}



# Reset user password

sudo rabbitmqctl change_password $USERNAME $NEW_PASSWORD



# Investigate potential security breaches

sudo rabbitmqctl list_connections | grep -i $USERNAME



# Restart RabbitMQ service

sudo systemctl restart rabbitmq-server


```