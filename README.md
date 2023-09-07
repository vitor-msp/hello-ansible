# Hello Ansible

## Wordpress started with ONE command

Project to practice Ansible configuration where I configure a VM with Wordpress and another with MariaDB.

![topology](assets/topology.png)

### Execution
1. Clone this repository
```
git clone https://github.com/vitor-msp/hello-ansible.git
```

2. Access the downloaded folder
```
cd hello-ansible
```

3. Starts and provisions the vagrant environment
```
vagrant up
```

4. Add a static dns entry in your hosts file (run as root!)
```
echo "127.0.0.1 www.wordpress.local" >> /etc/hosts
```

5. Open [this link](http://www.wordpress.local:8080/wordpress)

The wordpress configuration page will open and can be configured with the parameters that are in this project.

### Notes

1. The port 8080 in your machine must be free