/interface/vlan/add comment="Bootstrap Interface" interface=ether1 name=bootstrap0 vlan-id=2
/ip/address/add address=100.64.1.1/24 interface=bootstrap0
/ip/service/set www disabled=no
