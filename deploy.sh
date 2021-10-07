#! /bin/bash


print_title(){
	echo Deploy Script
}
print_date(){
	echo Date: $(date +'%d-%m-%Y %H-%M-%S')
}
# pass package name to function
install_package(){
	sudo apt-get install -y $1
}
apt_update(){
	sudo apt-get update
}
remove_old_site(){
	if [ ! -d /var/www/html/.git ]; then
          sudo rm -f /var/www/html/index.html
	fi
}
clone_website_code(){
	if [ ! -d /var/www/html/.git ]; then
	  sudo git clone https://github.com/octocat/Spoon-Knife /var/www/html/
	fi
}
pull_latest(){
	if [ -d /var/www/html/.git ]; then
	  cd /var/www/html/
	  sudo git pull https://github.com/octocat/Spoon-Knife
	fi
}

apache_check(){

	status=$(systemctl status apache2 | grep "Active: active" | wc -l)

	if [ $status == 1 ] ; then

		echo OK

	else

		echo Apache is not running
        fi
	}

print_title
echo "----------------------"
print_date
echo "----------------------"
apt_update
echo "----------------------"
install_package git
echo "----------------------"
install_package apache2
echo "----------------------"
remove_old_site
echo "----------------------"
clone_website_code
echo "----------------------"
pull_latest
echo "----------------------"
apache_check
echo "----------------------"
