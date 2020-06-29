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

Лекция 6. Домашнее задание
==========================
 В рамках домашнего задания создавался инстанс, правило VPN через утилиту gcloud.
 Доополнительно сделан простейший startup-script (без проверок, только команды).

 1. Создание инстанса со стартап скриптом:

    ```
    startup-script example:
      gcloud compute instances create reddit-app\
      --metadata-from-file startup-script=start-up-script.sh \
      --boot-disk-size=10GB \
      --image-family ubuntu-1604-lts \
      --image-project=ubuntu-os-cloud \
      --machine-type=g1-small \
      --tags puma-server \
      --restart-on-failure
    ```
1. Создание правила VPN:
    ```
    gcloud compute --project=infra-273514 firewall-rules create default-puma-serever --description="enable port 9292 for puma server" --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
    ```
---
Параметры для подключения:
```
testapp_IP = 34.107.69.196
testapp_port = 9292

Лекция 7. Домашнее задание
==========================

В рамках домашнего задания создавались образы для VM в GCP c помощью утилиты **packer**.

1. Создан базовый образ reddit-base. Перед запуском конфигурационный файл ubuntu16.json провалидирован (в репозиторий закоммичен пример файла с переменными - *variables.json.example*).
    ```
    packer validate -var-file variables.json ./ubuntu16.json
    packer build -var-file variables.json ./ubuntu16.json
    ```

2. Для выполнения омашнего задания со звездочкой, на основе базового образа создан образ reddit-full. Конфигурация описана в файле **immutable.json**
    ```
    packer build -var 'project_id=PR_ID' immutable.json
    ```

3. Для запуска инстанса VM на основе созданного образа можно воспользоваться командой (после запуска сразу же доступен вебсервер):
    ```
    gcloud compute instances create reddit-full \
      --zone=europe-west3-c \
      --machine-type=g1-small \
      --subnet=default \
      --tags=puma-server \
      --image=reddit-full-1593076989 \
      --image-project=infra-273514 \
      --boot-disk-device-name=reddit-full \
      --reservation-affinity=any \
      --restart-on-failure
    ```
