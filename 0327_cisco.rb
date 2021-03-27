Last login: Sat Mar 27 12:28:18 on ttys000
inamurateppei@mbp ~ % ssh -p 4444 teppei@localhost
teppei@localhost's password:
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.8.0-48-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

8 updates can be installed immediately.
0 of these updates are security updates.
To see these additional updates run: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.
*** System restart required ***
Last login: Thu Mar 25 21:57:03 2021 from 10.0.2.2
teppei@teppei-VirtualBox:~$ cat /etc/os-release
NAME="Ubuntu"
VERSION="20.04.2 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.2 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
teppei@teppei-VirtualBox:~$ Connection to localhost closed by remote host.
Connection to localhost closed.
inamurateppei@mbp ~ % ssh -p 4444 teppei@localhost
teppei@localhost's password:
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.8.0-48-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

0 updates can be installed immediately.
0 of these updates are security updates.

Your Hardware Enablement Stack (HWE) is supported until April 2025.
Last login: Sat Mar 27 16:34:26 2021 from 10.0.2.2
teppei@teppei-VirtualBox:~$ sudo apt-get install openssh-server
[sudo] teppei のパスワード:
パッケージリストを読み込んでいます... 完了
依存関係ツリーを作成しています
状態情報を読み取っています... 完了
openssh-server はすでに最新バージョン (1:8.2p1-4ubuntu0.2) です。
以下のパッケージが自動でインストールされましたが、もう必要とされていません:
  libfprint-2-tod1 libllvm10
これを削除するには 'sudo apt autoremove' を利用してください。
アップグレード: 0 個、新規インストール: 0 個、削除: 0 個、保留: 10 個。
teppei@teppei-VirtualBox:~$ systemctl start sshd
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
'ssh.service'を開始するには認証が必要です。
Authenticating as: teppei,,, (teppei)
Password:
==== AUTHENTICATION COMPLETE ===
teppei@teppei-VirtualBox:~$ systemctl enable sshd
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-unit-files ===
システムサービスファイルやその他のユニットファイルを管理するには認証が必要です。
Authenticating as: teppei,,, (teppei)
Password:
==== AUTHENTICATION COMPLETE ===
Failed to enable unit: Refusing to operate on alias name or linked unit file: sshd.service
teppei@teppei-VirtualBox:~$ systemctl status sshd
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: e>
     Active: active (running) since Sat 2021-03-27 16:35:05 JST; 7min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 676 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 694 (sshd)
      Tasks: 1 (limit: 2315)
     Memory: 4.5M
     CGroup: /system.slice/ssh.service
             └─694 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

 3月 27 16:35:05 teppei-VirtualBox systemd[1]: Starting OpenBSD Secure Shell se>
 3月 27 16:35:05 teppei-VirtualBox sshd[694]: Server listening on 0.0.0.0 port >
 3月 27 16:35:05 teppei-VirtualBox sshd[694]: Server listening on :: port 22.
 3月 27 16:35:05 teppei-VirtualBox systemd[1]: Started OpenBSD Secure Shell ser>
 3月 27 16:41:04 teppei-VirtualBox sshd[1180]: Accepted password for teppei fro>
 3月 27 16:41:04 teppei-VirtualBox sshd[1180]: pam_unix(sshd:session): session >
lines 1-18/18 (END)