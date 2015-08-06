# Questions to Answer

1. What are the topologies of interest?

2. What are the attacks/who are the attackers?

3. How does DHCP change the attack surface?

4. How does mDNS change the attack surface?

5. How does anycast change the attack surface?

6. How does the lack of user-identifiable credentials change the attack surface? 

# Analysis

## Assumptions

1. TURN traffic is encrypted (using, e.g., DTLS-SRTP)

## Topologies

1. Public shared network ("Starbucks")

    1. Customers attach to router

        1. Connection is frequently, though not universally, wifi

        2. Customers can frequently, though not universally, see each other’s traffic

        3. Customers can trivially spoof each other’s traffic

    2. Wireless router goes through captive portal

    3. Captive portal connects through ISP to DFZ

2. Residential networks

    4. Customers attach to router

        4. Router is frequently, though not universally, provided by ISP, which has varying degrees of administrative control over the router’s behavior

        5. For certain DOCSIS configurations, customers can see each other’s traffic, although it may take a relatively high degree of sophistication

    5. Wireless router goes through captive portal

    6. Router connects through ISP to DFZ

3. Enterprise Networks

4. Mobile Tethering

## Attacks

1. Interception

2. Redirection

3. Interruption

## Autodiscovery Impacts

### DHCP

### mDNS

### Anycast

## Impacts of Null Authentication
