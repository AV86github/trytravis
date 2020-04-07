# AV86github_infra
AV86github Infra repository

Лекция 5. Домашнее задание
==========================

0 Подключение к внутреннему хосту через *Bastion-host*
  '''
  ssh -i ~/.ssh/gcp_key -A -J gcp@35.210.136.106 gcp@10.132.0.4
  '''
0 Для подключения в одну команду `ssh <host-alias>` создаются *alias* в файле **~/.ssh/config**
  '''
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
'''
