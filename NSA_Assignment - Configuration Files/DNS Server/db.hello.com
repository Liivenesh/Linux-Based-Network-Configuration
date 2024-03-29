;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	ns1.hello.com. root.hello.com. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	ns1.hello.com.
ns1	IN	A	192.168.13.20
page1	IN	A	192.168.13.10
www	IN	A	192.168.13.10
lect	IN	CNAME	www
@	IN	AAAA	::1
