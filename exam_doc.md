# EXAM PROJECT DOCUMENTATION 
### The project contains the automation and provisioning of two Ubuntu-based servers, named “master” and “slave”, using Vagrant, with a bash script to automate the deployment of a LAMP (Linux, Apache, MySQL, PHP) stack, and cloned a PHP application from GitHub, with all necessary packages, and configured Apache web server and MySQL while using ansible to execute the bash script on the Slave node and cronjob to create check the server's uptime every 12:00am. the bash script is reusable and readable and can be accessible through the following repository: https://github.com/lukacaleb/MasterSlave-exams.git

### 1. Provisioning of "master" and "slave"
the file "vagrant-up.sh" when runned/executed, spines up the two ubuntu master and slave machines while creating a vagrantfile. ![img of vagrantfile](./details_of_steps/step-a-vagrantfile.png) 

![img of vagrant up](./details_of_steps/step-b.png)

![img of successful ssh login](./details_of_steps/step-c1.png)


### 2.  ssh into both "master" and "slave"
the ![image of successful pairing of master and slave](./details_of_steps/step-d1.png)

![image of successful pairing of master and slave](./details_of_steps/step-d2.png)

### 3.  bash script for the installation of LAMP

this step details the swcript that will be deployed on the slave using the ansible.... however fpor this step the script was only tested on the master-node to be sure its woirking


![bash_script](./details_of_steps/step-e-script1.png)


![bash_script](./details_of_steps/step-e-script2.png)

![bash_script](./details_of_steps/step-e-script3.png)

![bash_script](./details_of_steps/step-e-script4.png)


### 4.  successful deployment of LAMP (lavravel) on master-node

when the bash script ran successfully, here are the snapshotd of the successful deployment

![laravel_on_master](./details_of_steps/step-f.png)

![laravel_on_master](./details_of_steps/step-g-output.png)


### 5.  Installing ansible and pinging the slave from the master

here ansible was successfully installed on my master-node and the slave node was pinged from the master-node

![laravel_on_master](./details_of_steps/step-h-.png)



#### a. Ansible.cfg:- This is the brain and the heart of Ansible, the file that governs the behavior of all interactions performed by the control node.

#### b. Iventory:-the inventory is a list of managed nodes, or hosts, that Ansible deploys and configures. this inventory carries the ip address of the slave node in this project.

![inventory](./details_of_steps/step-h3-inventory.png)

#### c. slave-lamp-deploy.yml:- the Ansible Playbook in this project contains the blueprint of automation tasks on the slave node, which are IT actions executed with limited manual effort, across an inventory of IT solutions.

Here is my ansible playbook
![lansible_playbook](./details_of_steps/step-h-ansible-playbook.png)


### 6. the successful installation of LAMP on slave-node using ansible

after running the play book using ansible-playbook -i inventory slave-lamp-deploy.yml in the ansible dir; below are the results and the snapshots of the display of laravel page on my slave-node

display of the successful running of my playbook (slave-lamp-deploy.yml) on my master terminal
![laravel_on_slave](./details_of_steps/step-i-successfuly_running-my-ansible.png)

display of laravel on my slave-node/ip
![laravel_on_slave](./details_of_steps/step-j-laravel_on_slave_ip.png)


### 7. Running crontab

I added crontab to my bash script so it can be automatically installed when I am running my playbook

a. addition of crontab installation to script
![crontab](./details_of_steps/step-k-addition_of_crontab_to_script.png)

b.  ran the script again to add the cronjob and it was successful
![crontab](./details_of_steps/step-k-addition_of_crontab_to_script.png)

c. went to the slave noide to confirm that the cron job was successful and offcourse it was.
![cron_confirmation](./details_of_steps/step-l-result_of_adding_cron_to_playbook.png)

d. confirmation of the cron job from my slave-node

![cron_confirmation2](./details_of_steps/step-m-confirmation_from_slave.png)




