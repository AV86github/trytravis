# AV86github_infra
AV86github Infra repository

Лекция 5. Домашнее задание
==========================

1. Подключение к внутреннему хосту через *Bastion-host*
    ```
    ssh -i ~/.ssh/gcp_key -A -J gcp@35.210.136.106 gcp@10.132.0.4
    ```
1. Для подключения в одну команду `ssh <host-alias>` создаются *alias* в файле **~/.ssh/config**
    ```
    # defaults value:
    ForwardAgent yes

    # bastion host
    Host bastion
        User gcp
        HostName 35.210.136.106
        IdentityFile ~/.ssh/gcp_key

    # internal host
    Host inthost
        HostName 10.132.0.4
        User gcp
        IdentityFile ~/.ssh/gcp_key
        StrictHostKeyChecking no
        ProxyJump bastion
    ```
1. На хосте **bastion** установлен и настроен VPN сервер.

   Для подключения по vpn через GUI необходимо скачать файл конфигурации пользователя - *cloud-bastion.ovpn* и выполнить команду (запросит логин\пароль)
   ```
   sudo openvpn cloud-bastion.ovpn
   ```
1. pritunl имеет встроенную интеграцию с let's encrypt. Для использования валидного сертификата в настройках Lets Encrypt Domain указать *https://35-228-57-138.sslip.io*. Сертификат сгенерируется сам.
---
Данные для подключения
----------------------
```
bastion_IP = 35.228.57.138
someinternalhost_IP = 10.132.0.4
```
