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
