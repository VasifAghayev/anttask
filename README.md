#### To prepare all environment you need just download all code files and start machine with vagrant (Don't forget install gitbash, virtualbox and vagrant to your Widnows desktop):
```bash
$ git clone https://github.com/VasifAghayev/anttask.git && cd anttask
$ vagrant up
```

##### To initialize Jenkins at the first time just to to the inside of the Linux machine and get password from 'initialAdminPassword' file:
```bash
$ vagrant ssh
$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

##### In the http://10.100.1.201:8080 URL input this password (press 'Install sugested plugins' button) from previous command and create your admin account.

##### At the end just restart Jenkins service in the Linux console and run ANT job in the Jenkins console:
```bash
$ sudo systemctl restart jenkins
```

