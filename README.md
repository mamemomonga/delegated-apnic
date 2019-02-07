# 日本国内のIPアドレスを INPUT から COUNTRY_JP チェーンに接続するIPTablesルールを作成する。

## 生成

	$ make

## 適用

	$ cat var/iptables/JP | sudo iptables-restore --verbose --noflush

## 削除

	$ sudo iptables-save | grep -v '-j COUNTRY_JP' | sudo iptables-restore

## 確認
	$ sudo iptables -t filter -L -n | more

