#!/bin/bash


#Error Handling
OwnError()
{
    #Redirect All STDIN 2 STDOUT
    echo $@ >&2
    exit 1
}


# Install Apt-Add-Repository Python Tool
sudo apt-get install python-software-properties || OwnError "Unable To Install Python Software Properties :(" 


#Google Repository 
clear
echo "Install Repository For Google..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - || OwnError "Unable To Fetch Google Repository  :("
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list' || OwnError "Unable To Add Google Repository  :("


#Skype Repository 
clear
echo "Install Repository For Skype..."
sudo add-apt-repository ppa:upubuntu-com/chat || OwnError "Unable To Add Skype Repository  :("


#XAMPP Repository 
clear
echo "Install Repository For XAMPP..."
sudo add-apt-repository ppa:upubuntu-com/web || OwnError "Unable To Add XAMP Repository  :("


#Update The Cache
clear
echo "Updating Cache..."
sudo apt-get update || OwnError "Updating Cache Failed :("


#Install Common Softwares
clear
echo "Installing Git Vim Filezilla Google-Chrome Skype Oracle-Jdk"
sudo apt-get -y install git-core vim vlc filezilla google-chrome-stable skype openjdk-7-jre icedtea-7-plugin openjdk-7-jdk || OwnError "Installation Failed :("


#Install Web Server
clear
echo "Select The Webserver You Want To Install..."
OPTIONS=$(echo "LAMP XAMP Nginx")

select OPT in $OPTIONS;
do
    case $OPT in
    *)
        echo "You Selected $REPLY) $OPT"
        break
        ;;
    esac
done

if [ $REPLY -eq 1 ]
then
    clear
    echo "Installing LAMP Server"
    sudo apt-get -y install apache2 php5 libapache2-mod-php5 php5-mysql mysql-server mysql-client || OwnError "LAMP Server Installation Failed :("
elif [ $REPLY -eq 2 ]
then
    clear
    echo "Installing XAMPP Server"
    sudo apt-get -y install xampp || OwnError "XAMPP Server Installation Failed :("
elif [ $REPLY -eq 3 ]
then
    clear
    echo "Installing Nginx Server"
    sudo apt-get -y install nginx php5-common php5-mysql php5-xmlrpc php5-cgi php5-curl php5-gd php5-cli php5-fpm php-apc php-pear php5-dev php5-imap php5-mcrypt mysql-server mysqltuner || OwnError "Nginx Server Installation Failed :("
fi


#Install Netbeans
clear
echo "Downloading Netbeans..."
wget -c http://download.netbeans.org/netbeans/7.2/final/bundles/netbeans-7.2-ml-php-linux.sh || OwnError "Unable to download Netbeans :("
chmod u+x netbeans-7.2-ml-php-linux.sh
echo "Installing Netbeans..."
sudo ./netbeans-7.2-ml-php-linux.sh || OwnError "Unable to install Netbeans :("
sudo rm netbeans-7.2-ml-php-linux.sh
clear
echo "All Task Susscessfully Finished........"
