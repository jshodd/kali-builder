#!/bin/bash
echo 'Running system update'
apt update && apt upgrade -y
apt -y -qq install "linux-headers-$(uname -r)"
APT_LISTCHANGES_FRONTEND=none apt -o Dpkg::Options::="--force-confnew" -y dist-upgrade --fix-missing
apt -y -qq clean
apt -y autoremove

echo 'update searchsploit'
searchsploit --update

echo 'Installing windows exploit suggester'
git clone -q -b master https://github.com/GDSSecurity/Windows-Exploit-Suggester /opt/windows-exploit-suggester-git/

echo 'Installing onetwopunch'
git clone -q -b master https://github.com/superkojiman/onetwopunch.git /opt/onetwopunch-git/

echo 'Install icmpshi'
git clone -q -b master https://github.com/inquisb/icmpsh.git /opt/icmpsh-git/

echo 'install dnsftp' 
git clone -q -b master https://github.com/breenmachine/dnsftp.git /opt/dnsftp-git/

echo 'Download AccessChk'
timeout 300 curl --progress -k -L -f "https://web.archive.org/web/20080530012252/http://live.sysinternals.com/accesschk.exe" > /usr/share/windows-binaries/accesschk_v5.02.exe || echo 'Issue downloading accesschk_v5' 1>&2

timeout 300 curl --progress -k -L -f "https://download.sysinternals.com/files/AccessChk.zip" > /usr/share/windows-binaries/AccessChk.zip || echo 'Issue downloading accesschk.zip' 1>&2

echo 'link seclists to others'
[[ -d /usr/share/wordlists/seclists ]] || ln -sf /usr/share/seclists /usr/share/wordlists/seclists

echo 'extracting rockyou'
[ -e /usr/share/wordlists/rockyou.txt.gz ]\
	  && gzip -dc < /usr/share/wordlists/rockyou.txt.gz > /usr/share/wordlists/rockyou.txt
echo 'linking dirbuster wordlists to others'
[ -e /usr/share/dirbuster/wordlists ] \
	  && ln -sf /usr/share/dirbuster/wordlists /usr/share/wordlists/dirbuster

echo 'install CrackMapExec'
git clone -q -b master https://github.com/byt3bl33d3r/CrackMapExec.git /opt/crackmapexec-git/

echo 'Install Powershell Empire'
git clone -q -b master https://github.com/PowerShellEmpire/Empire.git /opt/empire-git/

echo 'Install Nishang'
git clone -q -b master https://github.com/samratashok/nishang /opt/nishang-git/

echo 'Install LinEnum'
git clone -q -b master https://github.com/rebootuser/LinEnum.git /opt/linenum-git/

echo 'Install Powerless'
git clone -q -b master https://github.com/M4ximuss/Powerless.git /opt/powerless-git/

echo 'Install JAWS'
git clone -q -b master https://github.com/411Hall/JAWS.git /opt/jaws-git/

echo 'Install Sherlock'
git clone -q -b master https://github.com/rasta-mouse/Sherlock.git /opt/sherlock-git/

echo 'Install Watson'
git clone -q -b master https://github.com/rasta-mouse/Watson.git /opt/watson-git/

echo 'Install AutoRecon'
git clone -q -b master https://github.com/Tib3rius/AutoRecon.git /opt/autorecon-git/
pip3 install -r /opt/autorecon-git/requirements.txt

echo 'Install Pspy'
git clone -q -b master https://github.com/DominicBreuker/pspy.git /opt/pspy-git/

echo 'Install Spacemacs'
git clone --single-branch --branch develop https://github.com/syl20bnr/spacemacs ~/.emacs.d

echo 'Installing Source Code Pro'
currentDir=$(pwd)
cd /tmp

wget https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip 
unzip 1.050R-it.zip
cp source-code-pro-*-it/OTF/*.otf /usr/share/fonts
rm -rf source-code-pro*
rm 1.050R-it.zip
cd $currentDir
fc-cache -f -v

echo 'Installing pyftpdlib'
pip install pyftpdlib

echo 'Marking smbver script as executable'
chmod +x /opt/smbver/smbver.sh
