#!/bin/sh
set -e

: "${FTP_USER:?FTP_USER is required}"
: "${FTP_PASSWORD_FILE:?FTP_PASSWORD_FILE is required}"

if [ ! -f "$FTP_PASSWORD_FILE" ]; then
  echo "[!] FTP password file missing: $FTP_PASSWORD_FILE"
  exit 1
fi

FTP_PASSWORD=$(cat "$FTP_PASSWORD_FILE")

id -u "$FTP_USER" >/dev/null 2>&1 || useradd -m "$FTP_USER"
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

mkdir -p /home/$FTP_USER/ftp/files
chown nobody:nogroup /home/$FTP_USER/ftp
chmod a-w /home/$FTP_USER/ftp
chown -R $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/files

cat > /etc/vsftpd.conf << VSFTPD_CONF
listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
pasv_enable=YES
pasv_min_port=40000
pasv_max_port=40005
local_root=/home/$FTP_USER/ftp
ssl_enable=NO
VSFTPD_CONF

echo "$FTP_USER" > /etc/vsftpd.userlist

echo "[i] Starting vsftpd"
exec /usr/sbin/vsftpd /etc/vsftpd.conf
