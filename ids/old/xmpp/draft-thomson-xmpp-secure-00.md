---
title: "Secure Messaging in XMPP"
abbrev: Secure Messaging in XMPP
docname: draft-thomson-xmpp-secure-00
date: 2015-09-29
category: std
ipr: trust200902

coding: us-ascii

pi:
  toc: yes
  sortrefs: yes
  symrefs: yes
  comments: yes

author:
 -
    ins: M. Thomson
    name: Martin Thomson
    email: martin.thomson@gmail.com
    phone: +1 650 903 0800
    org: Mozilla
    street: \
    city: Mountain View, CA
    country: US

 -
    ins: A. B. Roach
    name: Adam Roach
    email: adam@nostrum.com
    phone: +1 650 903 0800 x863
    org: Mozilla
    street: \
    city: Dallas
    country: US

normative:
  RFC5116:
  RFC6121:
  XEP-0045:
  XEP-0085:

informative:
  RFC5869:
  RFC7515:
  RFC7517:
  XEP-0160:


--- abstract

The history of secure messaging in XMPP is spotty. The long-running de facto
scheme, OTR, enjoys fairly wide implementation and use, but OTR suffers from
some serious usability and security shortcomings that make it unsuitable as a
basis for encryption.

This document describes an architecture that provides end-to-end
confidentiality and integrity for XMPP messaging. Solutions for both
multi-user and one-to-one messaging are provided.


--- middle

# Introduction

The history of secure messaging in XMPP is spotty. The long-running de facto
scheme, OTR, enjoys fairly wide implementation and use, but OTR suffers from
some serious usability and security shortcomings that make it unsuitable as a
basis for encryption. It also has a number of limitations that make it
unsuitable for advanced scenarios, such as multi-user conferences.

This document describes an architecture that provides end-to-end
confidentiality and integrity for XMPP messaging. Solutions for both
multi-user and one-to-one messaging are provided.

# Goals

This is a very simple proposition with a somewhat involved solution:

* one-to-one messaging is secured end-to-end

* multi-user chats are secured end-to-end

* messages can be sent to offline users

* the set of entities that can decrypt a message can be audited

* users are able to control whether their communications can be correlated across different venues

# Architectural Overview

This system aims to achieve the above goals by adding encryption to
chat-related XMPP functions.

This only aims to protect chat-related messaging. It provides only limited
protection for presence information.  The key agreement parts of this protocol
are intended to be generically applicable, but the application to file
transfer, jingle, and myriad other XMPP features is left for future efforts.

## The New Pieces

[Identity assertions](#identity-assertions) allow users to strongly authenticate others.
The identity assertion mechanism is also used as the basis of public
key distribution, which underpins several of the other building blocks.

[Encrypting a message](#message-encryption-details) is rather straightforward
once the symmetric encryption key is chosen.  Establishing the key used in
message encryption is more difficult. This design uses a scheme whereby
[encryption keys are advertised](#key-advertisement) prior to use. How this is
done varies only slightly between one-to-one messaging and
MUC.

Ensuring proper key distribution of the message-encrypting keys to a
potentially large and changing set of users is the most challenging and
involved piece of infrastructure to design and build. This architecture uses a
[secure roster](#user-and-muc-rosters) that makes and verifies strong
cryptographic assertions about participation.

Finally, pseudonymity functions allow a user to safeguard their privacy. The
addition of strong cryptography makes it easier for passive observers to
correlate activity, but pseudonymity ({{pseudonymity}}) allows users to
minimize what information about their activity is leaked to others.


## One-to-One Messaging

Message encryption for one-to-one messaging uses a unilateral key declaration
for key management.

### Publishing Key Exchange Data

Clients that wish to participate in encrypted messaging publish keying
material to their presence.  This includes a signing public key that is used
to authenticate messages and a Diffie-Hellman (DH) share used for exchanging
the symmetric keys used in encryption. Each client generates new keying
material that is bound to the full JID that they use (that is, each client has
its own keying material; there is no key associated with a user's bare JID).

Keys are published under a randomly generated identifier that is consequently
used to identify the key when it is used to encipher a message.

New clients can only be added if an existing client attests to the addition.
This is intended to stop a subverted server from adding clients. This uses a
form of the same [roster log](#user-and-muc-rosters) that is used for multi-party
chats.

> ISSUE: does this represent a UX issue? Five years ago, we might have been
concerned about users forgetting a password or losing their last device.
Today, this is less of a concern, especially if we subscribe to the principal
device theory (NOTE: The principal device here is a smartphone.  That device
goes with users everywhere and can serve as an anchor for security operations,
like adding a new client to the set of authorized clients for a JID.).

### Establishing Pairwise Keying Material

Prior to sending a message, a client first retrieves and validates the
presence of the intended recipient. A client that supports encryption will
include a valid DH share in their presence information.

The sending client then generates new symmetric keys that it will use with
this peer.  This key is enciphered toward all the clients in the recipient's
presence.

The key is also enciphered toward other authorized clients for the sender's
JID. This allows other clients to decipher the messages that other clients
have sent.  It also allows those clients to reuse the key.

It is also necessary for clients to re-send this information if a client is
added by sender or recipient. Otherwise, clients that reuse symmetric keys
will generate messages that new clients are unable to decrypt.

### Message Encryption

Once keying material has been selected or new keying material has been
advertised, messages are [encrypted and decrypted](#message-encryption-details) using that
symmetric key.

Recipients of the message recover the advertised keying material by retrieving
the presence of the sender and decrypting the enciphered key.

## Multi-User Chat

~~~
  +--------+    +--------+    +--------+
  |        |    |        |    |        |
  | Server |____| Server |____| Server |
  |   x    |    | muc@z  |    |   y    |
  |        |    |        |    |        |
  +--------+    +--------+    +--------+
      |           Roster          |
      |           Log             |
  +--------+                  +--------+
  |        |                  |        |
  | Client |                  | Client |
  | a@x/1  |                  | b@y/1  |
  |        |                  |        |
  +--------+                  +--------+
   Alias                       Alias
   xxx@x                       yyy@y
   (w/keys)                    (w/keys)


~~~


A user founds a MUC in the usual fashion (see {{XEP-0045}}, section 10.1). Two
changes are made:

1. The client creates a [a temporary JID](#pseudonymity) that is unique for
the room, and matching keying material that it will use exclusively with that
temporary JID.

2. The message that founds the room includes a founding entry for the
[secure roster log](#user-and-muc-rosters) for the room.  This is an element that establishes
the creating user as an owner in a manner that can be independently verified.

~~~
 Client             Server x             Server
   a@x                                    muc@z
    |                   |                   |
    |getalias for a@x   |                   |
    |------------------>|                   |
    |presence for xxx@x |                   |
    |<------------------|                   |
    |                   |                   |
    |xxx@x is a single-use JID: no presence?|
    |                   |                   |
    |create muc(xxx@x, first log entry)     |
    |-------------------------------------->|
    |room created       |                   |
    |<--------------------------------------|
    |configure          |                   |
    |-------------------------------------->|
    |room open          |                   |
    |<--------------------------------------|

~~~

All subsequent changes to the roster of the MUC need to be accompanied by a
message that authorizes the change.  This message is signed by the user that
proposes the change. All users verify the resulting series of changes that
accumulate to build up the room roster.

Unauthorized changes to the roster are therefore detectable. Keying material
is only shared with users that have been legitimately added to the roster.

### Inviting Other Clients

In order to invite a user to a chat, two pieces of identifying information for
the invited client need to be retrieved: a temporary JID and the keying
material for that client.

The inviting client generates a signed invitation and sends this to the bare
JID of the offline user. This invitation is a bearer token that can be
exercised by any client that has it.  The invitation must be encrypted using
one-to-one message encryption, or servers can steal and use it. A user with
the bearer token includes that in a signed roster log entry when they join the
room. The room adds the entry to the roster log if it can be validated.

~~~
 Client              Server             Server y             Client
   a@x                muc@z                                    b@y
    |                   |                   |                   |
    |getalias for b@y   |                   |                   |
    |-------------------------------------->|                   |
    |presence for yyy@y |                   |                   |
    |<--------------------------------------|                   |
    |invite yyy@y to muc@z (token)          |                   |
    |-------------------------------------->|                   |
    |                   |                   |connect            |
    |                   |                   |<------------------|
    |                   |                   |invitation         |
    |                   |                   |------------------>|
    |                   |                   |get alias for b@y  |
    |                   |                   |<------------------|
    |                   |                   |presence for yyy@y |
    |                   |                   |------------------>|
    |                   |join (presence, token)                 |
    |                   |<--------------------------------------|
    |                   |ok                 |                   |
    |                   |-------------------------------------->|
~~~

# Identity Assertions

The identity of users is one of the most important pieces of confidential
information in the context of a chat. Identity information need to be
confidentiality protected if they transit more than one server hop.

~~~
 Client             Server x             Client
   a@x                                     b@y
    |                   |                   |
    |get assertion      |                   |
    |------------------>|                   |
    |assertion          |                   |
    |<------------------|                   |
    |assertion          |                   |
    |-------------------------------------->|
    |                   |get identity       |
    |                   |<------------------|
    |                   |identity           |
    |                   |------------------>|
~~~

A new &lt;message> payload is defined to carry identity assertions.  That
assertion binds a bare JID to the signing public key used by a client to send
messages.

The identity assertion contains only a single piece of public information: the
domain name of the asserting entity.  The remainder is an opaque blob of data
that is consumed by the identity provider.

~~~
<message from="..." to="..." id="..." type="chat">
  <x xmlns="...identity#assertion">
    <domain>example.com</domain>
    <assertion>
      Gv3JuuWcMW0NZZib8pk+ZMPS4jnkmT0cFZQTPOTUM0yAktmseWAk2w
    </assertion>
  </x>
</message>
~~~

## Acquiring Identity Assertions

An identity assertion is acquired from the domain that is responsible for the
JID (that is usually the client's own server) by sending a query to that
server. The server uses the client's authentication credentials, which are
usually bound to a connection, to determine if the client owns the identifier.

~~~
<iq from="user@example.com/resource" 
    to="example.com" id="..." type="get">
  <x xmlns="...identity">
    <publicKey>...</publicKey>
  </x>
</iq>
~~~

The information that is signed is the signing key that the client intends to
bind to their identity.

The assertion that the server generates will ultimately be consumed by the
server that generated it, so it can be completely opaque. However, it should
contain enough information for the server to identify the JID of the client
that it relates to, as well as verify its authenticity.

~~~
<iq from="example.com"
    to="user@example.com/resource" id="..." type="result">
  <x xmlns="...identity#assertion">
    <domain>example.com</domain>
    <assertion>
      Gv3JuuWcMW0NZZib8pk+ZMPS4jnkmT0cFZQTPOTUM0yAktmseWAk2w
    </assertion>
  </x>
</iq>
~~~

 The assertion might also include limits on validity, such as an expiration
 time, as dictated by server policy.

## Validating Identity Assertions

> ISSUE: This validation mechanism relies on transitive trust in the server of
the client making the query. Confidentiality protection seems like the right
thing here.  Which is a second case for server-to-client confidentiality.

Clients that receive the identity assertion can then query the server that
issued it and request the identity that it contains. The server validates the
assertion, and either generates an error, or a message containing the
identity.

The query includes the assertion:

~~~
<iq from="other@example.net/check"
    to="example.com" id="..." type="get">
  <x xmlns="...identity#assertion">
    <domain>example.com</domain>
    <assertion>
      Gv3JuuWcMW0NZZib8pk+ZMPS4jnkmT0cFZQTPOTUM0yAktmseWAk2w
    </assertion>
  </x>
</iq>
~~~

A successful response includes the identity of the client, and the public key
that was asserted.

~~~
<iq from="example.com"
    to="other@example.net/check"
    id="..." type="get">
  <x xmlns="...identity#identity">
    <identity>user@example.com</identity>
    <publicKey>...</publicKey>
  </x>
</iq>
~~~

A client receiving this response checks that the domain part of the identifier
matches the server identity. Once this check is complete, the identity can be
associated with the public key. All messages sent with that public key can
thereafter be attributed to the identifier. Clients might also provide
indicators that the sender of authenticated messages has been verified.


# Message Encryption Details

A simple combination of symmetric encryption and asymmetric signing are used
to protect messages.

This wrapping scheme takes an unencrypted, serialized XMPP stanza. The process
adds a signature over this data. Then the signed content is encrypted.

~~~
content = cleartext || sender.sign(cleartext)
ciphertext = encrypt(keys[keyid].key, nonce, content)
~~~

The routing and message handling information from the cleartext (element
basename plus to, from, and type attributes) is added to a new stanza of the
same basename as the original. That is, &lt;iq> stanzas produce encrypted
&lt;iq> stanzas; &lt;message> stanzas result in encrypted &lt;message>
stanzas.  Unfortunately, these attributes govern message delivery in ways that
could cause compatibility issues if they were encrypted.

> ISSUE: The potential variations in these values leaks information; a future
study might identify mappings that allow for reductions in this leakage.  This
might include identifying cases where removing the resource identifier from
routing attributes is safe; or finding ways to map the range of stanza
elements and type attributes to a reduced set.  If there was a consistent set
of policies with respect to handling the different stanzas and types, this
would be easier.

A new &lt;e> element is added to the encrypted element.  The content of this
element is a base64 encoded string that contains the encrypted message.

This element includes attributes for a [key identifier](#key-identifiers) and
sequence number. The key identifier provides the information a recipient needs
to decrypt the message. The sequence number increases by one for every message
sent, allowing a receiver to detect when messages are dropped or lost.

## Encapsulation

Encrypted messages always use either the &lt;message> stanza or the &lt;iq>
stanza based solely on the nature of the exchange. Messages that require a
response from a specific client use the &lt;iq> stanza; all other messages use
&lt;message>.

Presence information can be encrypted, but this is necessarily mixed with
unencrypted data. An extension to the &lt;presence> element includes
confidential presence information. Note that presence information is
effectively broadcast; but any encrypted information will need a limited
audience, and all that audience will need to receive the same encryption key.

For example, the following message from {{RFC6121}} section 5.2.1:

~~~
<message
    from='juliet@example.com/balcony'
    id='ktx72v49'
    to='romeo@example.net'
    type='chat'
    xml:lang='en'>
  <body>Art thou not Romeo, and a Montague?</body>
</message>
~~~

Might be encrypted into a message of the form:

~~~
<message
    from='juliet@example.com/balcony'
    id='ktx72v49'
    to='romeo@example.net'
    type='chat'>
  <e xmlns='...tbd...' key='MSPw9g5tlj9BZGF6' seqno='1'>
    Ume+BIoftGYSA2Z2yJMyycNvMJmpysdfQY2wcrCiK0AtsrqWZR6KcTTEkewfepW
    1FGIYpmZFLGSybwRZ+VcOHdlOl9aYVzdSPDmXrM2mrJGhz7sxphlKfPlw6ZrJ7Dt
    Gq9IM0epBu6E4hb9DDb4+ORR2Ap7+cAD+ICMJQMySuq/mVE7ybxxWzloU30Lb
    Gn/lzU9cmUww3yCI98WZAcHoeTQXJ0b/qjUpqYjJwCshaCH_HH7daks0TS3IojH
    OancJmsBd5RYqMHekrpD9RpuWGGzR-ro0ScRbdsLnzXmYl62qSnyw1qCMNuJE
    5o5_uraBRgEkCDlXas
  </e>
</message>
~~~

This removes the language indicator from the unencrypted stanza.

> ISSUE: What do existing clients do when they see an encrypted message? The
addition of one client that supports encryption causes encrypted messages to
be sent to that user. Other clients that haven't yet been upgraded will have
to deal with the encrypted messages somehow.  It might be possible to add a
&lt;body> element with a generic message, but that would need to be
internationalized and repeating that block in every message seems wasteful.
Ideally, encrypted messages would just be discarded.  To do: check with
someone who might know.

## Symmetric Encryption

Authenticated Encryption with Additional Data (AEAD) {{RFC5116}} is used to provide
confidentiality of messages, as well as integrity against unauthorized
recipients.

The AEAD key is either [advertised](#key-advertisement) or reused from a prior
advertisement. The advertisement of the key establishes the scheme that is
used.

### Nonces

The sequence number on each message determines the nonce that is used with the
AEAD. For a given combination of sender and key identifier, sequence numbers
cannot repeat without risking compromise of the confidentiality and integrity
provided by authenticated encryption. The following nonce derivation method is
used (using HKDF as defined in {{RFC5869}}):

nonce = HKDF(0, sender.fullJID, 'nonce', N_MAX) XOR seqno

This nonce selection ensures a negligible probability of nonce reuse as long
as each sender correctly increments the sequence number. Recipients can verify
that sequence numbers are not reused.

### Symmetric Algorithm Agility

Key identifiers also identify the AEAD algorithm that is used to encipher a
message.  That information is carried in the key advertisement.

Messages may be enciphered multiple times with different keys.  This allows
new encryption schemes to be deployed, at the cost of sending some messages
multiple times. This is only necessary if some potential recipients only
support old AEAD algorithms.

This presents a downgrade attack vector if an attacker can convince a sender
that a legitimate client supports a weaker cipher suite.  However, key
advertisements are authenticated, so the only point for a potential downgrade
is a break in the signing key that a recipient uses, which is much more
serious a problem than a mere downgrade.

### Message Drop Attacks

Selectively dropping messages can be used by an attacker to disrupt
communications.  Even without visibility into the contents of messages, side
channels might be used to learn of the timing of important messages.

For this reason, the sequence number of messages is integral to the encryption
of messages. Sequence numbers increase at a constant interval for messages
sent by the same client, allowing dropped messages to be detected.  Since
there is an expectation of reliability and in-order message delivery, clients
should highlight where message are missing.

## Signature

A signature on messages is necessary to prevent impersonation of other MUC
participants. This means that repudiation of the form that OTR claims to
provide is not offered, because that requirement is incompatible.  Note
however that a temporary MUC using [a temporary JID](#pseudonymity) and no
[identity assertion](#identity-assertions) provides only circumstantial means of
attributing activity to a user.

## Decryption and Validation

The reverse of this process is used to decrypt messages. Encrypted information
is authenticated and the signature validated. The decrypted and verified
stanza is then parsed as though it were in place of the current stanza.

A client only needs to decrypt one &lt;e> element, since each is required to
include the same content. All unencrypted content in the stanza is removed and
consequently ignored.

It is important that the receiver check that the stanza is whole and valid
before allowing it to be processed further. A server that is unable to decrypt
a message cannot be relied upon to ensure that messages are valid.

In the cleartext protocol, framing issues do not propagate easily, since they
directly affect stanza processing. Encrypted stanzas allow a malicious peer to
generate invalid -- especially unterminated -- XML. Extraneous bogus frames
resulting from unchecked XML might be exploited to impersonate a server toward
a receiving client. Matching the enciphered **from** attribute against the
included signature is also necessary to prevent other forms of impersonation.

Additional checks might be necessary for specific stanzas, types, or content.
In general, any checks that might have been possible on a server need to be
carried out by clients that received encrypted stanzas.

## Presence Encryption

Some presence information might be confidential.  For instance, many users
include a status message that is shared with their friends. Encrypting status
is highly desirable.

Direct children of the presence stanza may be encrypted in an &lt;e> element.
These necessarily use a different key than those used for other types of
messaging to avoid problems with controlling key disclosure.

> ISSUE: we need to expand on the definition of presence.  This could require
new messaging arrangements to support retrieval of encrypted presence
information. It definitely needs more expansion on key management. At its
core, this might reuse the same systems used for one-to-one messaging, but the
broadcast nature of presence means that there is a larger audience for any
given message, which increases the potential for keys to be unavailable to
valid recipients.

## Chat State Notifications

Clients are required to encrypt chat state notifications {{XEP-0085}}.
However, these messages are useless to an offline client.  A server that can
see these messages is required to drop them (see {{XEP-0160}}, section 3), but
encrypted messages can't be distinguished from other more important messages.

Thus, clients are required to suppress chat state notifications when a peer is
offline. This allows a server to fake presence for a user in order to filter
out chat state notifications, or suppress the feature, but the value of this
information isn't great and this causes an attacker to actively modify or
suppress messages to mount the attack.

## Layers of Encryption

A group chat might use one-to-one message encryption to send messages to a
user. There's a question about what advantage that provides.  Removing the
nick from messages might be of some advantage, but that advantage is better
managed with [pseudonymity](#pseudonymity).

# Key Advertisement

Users publish the encryption keys that they use for one-to-one messaging to
their presence. In an MUC, they instead use the presence that they advertise
to the room.

## Asymmetric Key Advertisement

Two forms of asymmetric keys are used by clients: a signing key that is used
to authenticate all forms of messages sent by that client, and a
Diffie-Hellman (likely elliptic curve) share that is used in symmetric key
advertisements.

Asymmetric signing keys are added to and form the basis of the
[roster log](#user-and-muc-rosters) maintained for each user or MUC.  Diffie-Hellman shares
are added to presence information.

Diffie-Hellman shares are added to a presence document as JWS-signed {{RFC7515}}
JWK Set {{RFC7517}}.  Each JWK in the set includes a key identifier that other
clients use to identify the key.

~~~
<presence from="jid@example.com/resource">
  <x xmlns="....:shares">
    {
      "payload":
       "eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9le
        GFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ",
      "signatures":\[
       {"protected":"eyJhbGciOiJSUzI1NiJ9",
        "header": {"jwk": { \xe2\x80\xa6 } },
        "signature":
         "cC4hiUPoj9Eetdgtv3hF80EGrhuB__dzERat0XF9g2VtQgr9PJbu3XOiZj5
          RZmh7AAuHIm4Bh-0Qc_lF5YKt_O8W2Fp5jujGbds9uJdbF9CUAr7t1dnZcA
          cQjbKBYNX4BAynRFdiuB--f_nZLgrnbyTyWzO75vRK5h6xBArLIARNPvkSj
          tQBMHlb1L07Qe7K0GarZRmB_eSN9383LcOLn6_dO--xi12jzDwusC-eOkHW
          EsqtFZESc6BfI7noOPqvhJ1phCnvWh6IeYI2w9QOYEUipUTI8np6LbgGY9F
          s98rqVt5AXLIhWkWywlVmtVrBp0igcN_IoypGlUPQGe77Rw"}\]
     }
  </x>
</presence>
~~~

Each key that is encrypted toward this client uses the "kid" parameter on the
JWK to identify the key that they are encrypting towards.

Diffie-Hellman advertisements are signed to ensure that they are only provided
by authorized clients. This allows these advertisements to be generated prior
to a client becoming authorized.

## Symmetric Key Advertisement

A key advertisement contains the following information:

* A key identifier

* An encryption scheme identifier

* The full JID of the advertising client (a temporary JID for MUC)

* The full JID of the key recipient (a temporary JID for MUC)

* A key identifier for the DH share for the advertising client

* A key identifier for the DH share for the key recipient

* A symmetric key, encrypted using a key derived from the DH exchange

* An expiration date and time, after which the key must not be used for enciphering new messages, though it may be used to decipher old messages

* A key identifier for the signing key

* A signature over this entire structure, generated using the private signing key

> Open Issue: Rather than use key identifiers for DH shares it might be easier
to exchange the share itself, since that is unambiguous and likely not
significantly different in size.  That makes the advertisement self-contained.
Note that this would not absolve the key recipient of the need to check that
the DH share (or signature key) is from a valid and authorized entity. The use
of a key identifier makes that check implicit and avoids some types of
mistake.

The signature is required to ensure that a key is not replayed and
consequently reused. A message with a signing key that is either not known or
from an entity that is not permitted to participate in a conversation must be
discarded.

A complete key advertisement includes the same information repeated for each
recipient. Common information, and the signature, don't need to be repeated. A
single signature has implications for key lifetime.

## Key Identifiers

Key identifiers are used to select the key that is used for encryption and
decryption. Each key advertisement has an associated key identifier.

Care needs to be taken to ensure that key identifiers are unique within the
context that they are created. Since keys are proposed and used by multiple
actors without synchronization, identifying keys with a large identifier (such
as a GUID) is advised.

## Key Lifetime

Keys are advertised with an expiration time that limits the time when they can
be used for encryption. However, offline clients need to be able to read
messages that are generated while they are offline. Clients that are offline
for extended periods need to be able to recover the keys that were used to
encrypt those messages.

Keys advertised to user presence are therefore persisted until their intended
recipients have retrieved and acknowledged keys. Since each key is encrypted
toward a specific client, once that client retrieves the key it can be
removed, though explicit acknowledgment might be desirable. Note that the set
of recipients includes all client instances of the intended recipient, plus
all client instances of the sender.

Once the complete set of potential recipients have acknowledged a key, then it
can be removed.  This might use implicit acknowledgment for client instances
of the sender, since the server can track message delivery to those clients.
Explicit acknowledgment is necessary for remote clients of the recipient.

Keys advertised within an MUC enter the chat transcript.  New messages to the
chat are expected to use the latest key, so old keys only need to be
maintained to account for race conditions where messages might be sent without
knowledge of the most recent key. Keys that are superseded by a newer key can
therefore be disposed of after a short duration.

Here, the ordering of messages to the MUC is used to determine which key is
used. That ordering allows clients to remove and discard older keys.

# User and MUC Rosters

All efforts to encipher messages are largely pointless if the architecture
permits servers to add themselves to the set of clients and thereby acquire
keying material. The roster of clients that are authorized to represent a
user, or which are part of an MUC, is a resource that needs strong integrity
protection to prevent a malicious server from becoming part of conversations.

The canonical form of each roster takes the form of a log. A roster log is a
verifiable chain of changes to the roster. The log can be validated by any
entity and the set of participants validated.

Each entry in the log identifies the entry that immediately precedes it by
including a cryptographic hash of that entry.  This ensures that a valid log
cannot include divergent or conflicting changes (this does not prevent
[certain forms of manipulation](#roster-security-limitations) by servers). Each entry is
signed by the entity that generated the entry, allowing changes to be
attributed and validated.

A successfully validated roster log can be used by a client to determine the
set of clients that a [key advertisement](#key-advertisement) needs to be
enciphered toward. In ensuring that a validated roster log is used prior to
advertising new keys, clients can ensure that only authorized clients receive
those keys.

## Roster Entries

There are several types of entry that can be recorded into the roster log. The
following table summarizes the different types of log entry.


|---
| Entry Type | Parameters | Who can add | Notes
|-|:-|:-|:-
| Set Room Type | Room Owner, Room Type | Room Owner | This entry must be the first entry in a MUC roster log. This also establishes the signer as a room owner. (MUC only)
| Set Room Permissions | Permissions | Room Owner | The set of permissions are taken from {{XEP-0045}}, limited to those that can change. (MUC only)
| Set Affiliation | Subject, Affiliation | Authorized Client | The maximum role that the subject can assume might be included, or it might be determined based on {{XEP-0045}} affiliation. (MUC only)
| Set Client State | Subject, State | Authorized Client | This determines whether the identified client is authorized or not. (One-to-one only)
| Redeem Ticket | Subject, Invitation Ticket | Subject | This in effect allows for a Set Affiliation entry to be generated in two parts.
| Rekey | Old Key, New Key | Subject | Used by a client to replace the keying material it uses without changing the affiliation of the client. This entry is signed with the old key. This invalidates the old key for future use.


Subjects are identified in the roster log by their signing public key.

Each log entry includes a hash of the message that precedes it. This ensures
that a log entry cannot be replayed on top of a different roster state.

The owner (see {{XEP-0045}}, section 5.2) affiliation is required to
perform important tasks, like setting the room type or altering configuration
options.  For setting the affiliation or state of other clients, a combination
of factors determine whether an operation is valid: the affiliation of the
user performing the change, the room type, and the room
permissions.

### Tracking Affiliations and States

The roster log becomes the source of truth for affiliations (or for client
state).  This has a range of consequences, some of which result in divergence
from unprotected chat or MUC.

The roster log is public information.  This means that affiliations and states
can be seen by any client. This information is advertised to room participants
in the presence advertisements, but rooms can be configured to suppress
presence. Access to affiliation information for offline users (member, admin,
and owner lists) is controlled.

The design to this point assumes that there is some functional distinction
between an affiliation of Member and an affiliation of None. This is not the
case in an Open or Unmoderated room. For those room types, the roster log does
not need to track affiliation transitions between Member and None, though it
may if the room type could change.

> ISSUE: Is there any sense in encrypting communications when a room is open or
unmoderated?  Since anyone can join, the main value is in having some
knowledge about the set of clients that might have received a message. Given
the high level of pseudonymity used, is even that much achievable?

The Outcast affiliation cannot be tracked, which makes it impossible to ban a
user from an MUC. That is not a consequence of the roster log design, but a
result of requiring the use of [pseudonyms](#pseudonymity) in MUC.

### MUC Invitation Tickets

An offline client or user is invited to an MUC by sending them an invitation
ticket.

An invitation ticket contains all the information that a Set Affiliation
roster log entry might have, without a subject.  That subject is provided when
the ticket is redeemed.

* Affiliation (and role)

* GUID (or equivalent randomness)

* A signature from a client that is authorized to make the change

Invitation tickets are bearer tokens. That means that distribution of these
messages needs to use confidentiality protection, such as that provided by
secure one-to-one messaging.

A client can revoke any unused tickets that they have sent by rekeying.
Consequently, new invitations have to be issued if a client updates their
keys.

### User Roster Management

It might seem obvious that an equivalent ticket mechanism could be used for
managing user rosters. A user that has a new device, could send that device an
invitation to join their list of clients.

However, offline invitations for alternative clients don't have a
confidentiality protection mechanism available: MUC invitations can be
one-to-one encrypted because the user roster exists and provides for that
confidentiality protection.  The same capability is not available for the
client roster, which introduces a bootstrapping problem.

The safest option here is to leave this unspecified and require that clients
add other clients to the user roster directly. That means that new clients
need to come online and advertise keys before they can be invited to represent
a client.

### Roster Update Protocol

A simple IQ protocol is defined for updating the roster.  A client sends a new
roster element (a JWS signed JSON structure) to the server that maintains the
roster as follows:

~~~
<iq from="user@example.com/resource"
    to="muc@example.com"
    type="set">
  <x xmlns="...:roster">
    ... a JWS-signed blob ...
  </x>
</iq>
~~~

The server can validate this and add it or not based on that validation. Note that this exposes clients to various forms of denial of service mounted by the browser, primarily a refusal to take valid updates.

## Roster State

Clients process a roster log to produce their own view of the state of the
roster. This ultimately results in a set of clients that are authorized to
receive key advertisements.

Each client maintains their own view of the state of the roster for other
clients and each MUC that they participate in.  This state can be recovered at
any time by re-processing the roster log. Clients use this state to select the
clients that keying material can be shared with. Clients also use roster state
in determining whether a new roster log entry is valid.

A roster log can enter a broken state if an invalid entry is added. Servers
are expected to validate new entries and ensure that this doesn't happen, but
it is possible that errors or malice could cause invalid entries to be
recorded and distributed. Clients are required to freeze the state of a roster
at the point where the last valid entry is found.

## Roster Security Limitations

We have to assume that an attacker (in particular, the server that maintains
and distributes a roster log) can affect how a roster log makes progress.

This can be used to an attacker's advantage. An attacker can withhold new
changes from clients, or from a subset of clients. By preventing some subset
of clients from learning about changes, an attacker can freeze the state of a
roster from the perspective of those clients.

This could potentially be used to stimulate the creation of multiple different
changes from the same starting state.  The attacker might then choose to allow
changes only that are favorable to it.

In general, this means that the progress of a roster state has to be viewed as
a directed graph, not a linear sequence. The nodes of the graph correspond to
states of the roster. The outbound edges from any node are the valid set of
changes that might be made from that state by any agent that is currently
present.

Given sufficient time, a server can direct progress along any edge that is
presented to it. Also, the server can freeze the node that an individual
client sees by refusing to forward entries to that client.

More opportunities are available to the server if clients rely on the server
to maintain the entirety of the log state.  A client that maintains no state
about a roster opens itself to the possibility that the server could set the
state of the roster to any node in the directed graph, including old states.

## Mitigating Attacks

The obvious protection clients can use to limit the potential for
unconstrained state manipulation is remembering the state of a log. This can
be limited to the last entry (or the hash of that entry), even if clients need
to discard other state. This prevents roster progress from being rewound, but
it cannot do anything about a server withholding entries that a client hasn't
seen.

The potential for attacks based on withholding log entries is a potentially
serious concern. The design of XMPP naturally provides a single central
controller: the server.  That central controller can provide excellent
consistency, if we assume that the server chooses to present the same view of
the roster log to all clients.  However, if the server is malicious, then it
represents a single point of failure.

> ISSUE: It might be that this is an acceptable condition, given the limited
opportunity that the server has to affect change. An alternative design would
decouple the roster management function from the message delivery function,
which would allow this to be independent of the XMPP server. That opens other
options, like distributed or redundant roster stores, though a decoupled
design adds new error conditions for every problem it aims to address.

# Pseudonymity

Providing end-to-end confidentiality and integrity greatly improves the
privacy profile of XMPP. However, exposure of a user's JID to a group chat
server allows for a greater degree of traffic analysis. This proposes the use
of a pseudonym to minimize the information that is made available to a group
chat server.

A new service is added whereby a client can request the creation of an
unlinked pseudonym. That pseudonym is a temporary JID.  A temporary JID is a
bare JID that is aliased to another bare JID. Resource identifiers can then be
selected by the client so that messages routed to pseudonym can't be linked to
their primary identifier.

A pseudonym allows a client to join a group chat without exposing their
identity to the group chat.

A pseudonym request is simple:

~~~
<iq from="user@example.com/resource"
    to="example.com"
    id="..." type="get">
  <x xmlns="...pseudonym"/>
</iq>
~~~

The response is equally simple:

~~~
<iq from="user@example.com/resource"
    to="example.com"
    id="..." type="result">
  <x xmlns="...pseudonym">7ee6df7a831198624131@example.com</x>
</iq>
~~~

Clients are able to include the new pseudonym in any interaction that they
initiate and other servers and users will be unable to distinguish that user
from any other user at the same server.

Messages for a pseudonym will be routed to the bare JID of the user, subject
to the normal rules for routing of messages to a bare JID, even if the message
contains a resource identifier.

# Acknowledgements

TBD

# Security Considerations

The entire contents of this document deal with matters of security.

# IANA Considerations

This document makes no requests of IANA



{::comment}
The XEP references giving you trouble? You'll need to hack your kramdown-rfc2629
to add this; find the function "bibtagsys" and modify it like this:

def bibtagsys(bib)
  if bib =~ /\Arfc(\d+)/i
    rfc4d = "%04d" % $1.to_i
    [bib.upcase,
     "#{XML_RESOURCE_ORG_PREFIX}/bibxml/reference.RFC.#{rfc4d}.xml"]
  elsif bib =~ /\Axep-(\d+)/i
    rfc4d = "%04d" % $1.to_i
    [bib.upcase,
     "http://www.xmpp.org/extensions/refs/reference.XSF.XEP-#{rfc4d}.xml"]
  elsif bib =~ /\A([-A-Z0-9]+)\./ &&
        dir = Kramdown::Converter::Rfc2629::XML_RESOURCE_ORG_MAP[$1]
    bib1 = bib.gsub(/\A[0-9]/) { "_#{$&}" } # can't start an ID with a number
    [bib1,
     "#{XML_RESOURCE_ORG_PREFIX}/#{dir}/reference.#{bib}.xml"]
  end
end

On OS X, this ends up being installed at:
/usr/local/lib/ruby/gems/2.2.0/gems/kramdown-rfc2629-1.0.28/bin/kramdown-rfc2629

{:/comment}

