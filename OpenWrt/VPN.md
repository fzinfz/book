# OpenVPN
https://openwrt.org/docs/guide-user/services/vpn/openvpn/server#key_management

VPN_PKI="/etc/easy-rsa/pki"
export EASYRSA_PKI="${VPN_PKI}"
export EASYRSA_CERT_EXPIRE="36500"
cp -p pki/private/*.key /etc/openvpn/
cp -p pki/issued/*.crt   /etc/openvpn/
cp -p pki/{ca.crt,dh.pem}  /etc/openvpn/

service openvpn restart