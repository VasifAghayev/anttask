#!/bin/bash
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update && sudo apt-get install -y python-software-properties debconf-utils
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt install -y oracle-java8-installer oracle-java8-set-default ant git-all unzip
JAVA_HOME=/usr/lib/jvm/java-8-oracle
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo apt-add-repository "deb https://pkg.jenkins.io/debian-stable binary/" -y
sudo apt-get update && sudo apt-get install -y jenkins
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
echo '%jenkins ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/jenkins

links='https://jar-download.com/cache_jars/org.apache.ant/ant-junit/1.9.10/jar_files.zip
https://fossies.org/linux/misc/checkstyle-8.12-all.jar
https://github.com/pmd/pmd/releases/download/pmd_releases%2F6.7.0/pmd-bin-6.7.0.zip
https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/sun_checks.xml
https://netix.dl.sourceforge.net/project/jsudoku/jSudoku/jSudoku-1.3/jSudoku-src-1.3.tar.gz'
for link in $links
do 
    wget $link -P temp/
done
unzip temp/jar_files.zip -d temp/
mkdir -p ~/jsudoku/{src,repo,lib,cslib,META-INF,reports}
cp temp/{hamcrest-core-1.3.jar,junit-4.12.jar} ~/jsudoku/lib
cp /vagrant/scripts/temp/{build.xml,build.properties} ~/jsudoku/
cp /vagrant/scripts/temp/MANIFEST.MF ~/jsudoku/META-INF
cp temp/{checkstyle-8.12-all.jar,sun_checks.xml} ~/jsudoku/cslib
tar -zxf /home/vagrant/temp/jSudoku-src-1.3.tar.gz -C /home/vagrant/temp/ && mv /home/vagrant/temp/Sudoku-src/* ~/jsudoku/repo
cd ~/jsudoku/repo
git init
git config --global user.name "Vasif Aghayev"
git config --global user.email "vasif.aghayev@gmail.com"
git add org/
git add oyg/
git commit -m "First commit to repo"
unzip /home/vagrant/temp/pmd-bin-6.7.0.zip -d ~/jsudoku/
cd ~/jsudoku && mv pmd-bin-6.7.0 pmd
~/jsudoku/pmd/bin/run.sh pmd -d /usr/src -R java-basic -f text
cp /vagrant/scripts/temp/jobs.tar.bz2 /var/lib/jenkins
cd /var/lib/jenkins
systemctl stop jenkins
mv jobs backup-jobs
tar -jxvf jobs.tar.bz2
chown -R jenkins:jenkins jobs
systemctl start jenkins
