#! /bin/bash

echo "--------------------------"
print_title(){
	echo Deploy Script
}
echo "--------------------------"
print_date(){
	echo Date: $(date +'%d-%m-%Y %H-%M-%S')
}
echo "--------------------------"
# pass package name to function
install_package(){
	sudo apt-get install -y $1
}
echo "--------------------------"
apt_update(){
	sudo apt-get update
}
echo "--------------------------"
remove_old_site(){
	if [ ! -d /var/www/html/.git ]; then
          sudo rm -f /var/www/html/index.html
	fi
}
echo "--------------------------"
clone_website_code(){
	if [ ! -d /var/www/html/.git ]; then
	  sudo git clone https://github.com/octocat/Spoon-Knife /var/www/html/
	fi
}
pull_latest(){
	if [ -d /var/www/html/.git ]; then
	  cd /var/www/html/
	  git pull https://github.com/octocat/Spoon-Knife
	fi
}
echo "--------------------------"

apache_check(){

	status=$(systemctl status apache2 | grep "Active: active" | wc -l)

	if [ $status == 1] ; then

		echo OK

	else

		echo Apache is not running

	}

print_title
print_date
apt_update
install_package git
install_package apache2
remove_old_site
clone_website_code
pull_latest
