## SMTP Server
1. Add PTR record
   PTR domain record - IP of your server with FQDN value from EHLO message (if ```SERVER_NAME=mail.domain.org``` at ```.env``` and external IP of your smtp server ```123.124.125.126``` add these DNS record at DNS server of your internet provider (/var/named/125.124.123.in-addr.arpa)
   ```
   126 IN PTR mail.domain.org.
   ```
   To check
   ```
   nslookup 123.124.125.126
   126.125.124.123.in-addr.arpa     name = mail.domain.org.
   
   Authoritative answers can be found from:
   ```



1) TXT domain record - @ with value "v=spf1 ip4:123.124.125.126 -all"



1) TXT domain policy record - _domainkey with value "o=-; r=postmaster@domain.org;"

(n - notes; o - policy, '-' sign all messages, '~' default, may sign; r - invalid verification reporting to; t - 'y' testing mode)

      

2) TXT domain record - mail._domainkey with value "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDBe1ZdRmEuiRQvbMkyrOudrMdSTR7+wUhtNDajgwfOgNFVmaaMfUbrsDEgF3Dm2xj4r7RY4ivJ/kaUlc9EXTYYkc4YVgHx+Y69JL46M68QuVCcnrvrwO9rUZaXq78nimietMqH7G/355b16SlVYBk9U+RgXqz98POJxCixZrPuswIDAQAB"

(g - sending address for this selector; k - type of key; n - notes; p - public key, mandatory tag, empty value if key was revoked; t - 'y' testing mode)


DMARC (https://tools.ietf.org/html/rfc7489#section-6.3)

1) TXT domain record - _dmarc with value "v=DMARC1; p=none; adkim=s; aspf=s; fo=1:d:s; pct=100; rf=afrf; ri=86400; rua=mailto:postmaster@domain.org; ruf=mailto:postmaster@domain.org;"

(adkim - DKIM alignment mode, 'r' - relaxed default, 's' - strict; aspf - SPF alignment mode, 'r' - relaxed default, 's' - strict; fo - failure report, 0 is default - send report if all (DKIM and SPF) methotd fail, 1 - send report if any (DKIM or SPF) methotd fail, d - send DKIM failure report regardless of alignment, s - send SPF failure report regardless of alignment, this is colon-separated value; p - receiver policy, 'none' - no action, 'quarantine' - place into spam folder, 'reject' - reject during SMTP session; pct - percentage of messages DMARC policy applied; rf - format of report, 'afrf' - default; ri - aggregate interval, '86400' - default daily; rua - address for aggregate feedback; ruf - address for message-specific failure report; sp - receiver policy for subdomains, 'none' - no action, 'quarantine' - place into spam folder, 'reject' - reject during SMTP session, 'p' policy of some subdomain will applied if exist, and this 'sp' will be ignored; v - version, all _dmarc record will be ignored if 'v' doesn't exist, must be equal DMARC1)


Example check domain domain.org by nslookup

Linux - nslookup -type=txt mail._domainkey.domain.org

Windows - nslookup -query=txt mail._domainkey.domain.org


Create Reverse DNS record

Resource Manager (not classic) VM Reverse DNS Record

Our domains DNS records

nslookup -type=txt domain.org

nslookup -type=txt _domainkey.domain.org

nslookup -type=txt google._domainkey.domain.org

nslookup -type=txt _dmarc.domain.org


nslookup -type=txt domain.org

nslookup -type=txt _domainkey.domain.org

nslookup -type=txt google._domainkey.domain.org

nslookup -type=txt _dmarc.domain.org


nslookup -type=txt news.domain.org

nslookup -type=txt _domainkey.news.domain.org

nslookup -type=txt ml._domainkey.news.domain.org

nslookup -type=txt _dmarc.news.domain.org


nslookup -type=txt domain.org

nslookup -type=txt _domainkey.domain.org

nslookup -type=txt mail._domainkey.domain.org

nslookup -type=txt _dmarc.domain.org

## Links
1. PTR https://tools.ietf.org/html/rfc2505#section-1.4
1. SPF https://tools.ietf.org/html/rfc7208
1. DKIM1 https://tools.ietf.org/html/rfc4870
1. DKIM2 http://domainkeys.sourceforge.net/
1. DKIM3 http://www.dkim.org/
1. DKIM4 https://www.xpertdns.com/billing/knowledgebase/1/DomainKeys-or-DKIM.html)
1. DKIM5 https://gaiaes.com/article/domainkeys-identified-mail-dkim-and-postfix-header-checks
https://habrahabr.ru/post/106589/
https://www.mail-tester.com/web-68bg8
https://www.mail-tester.com/web-aozar
https://www.spamhaus.org/pbl/removal/verify/
