---
title: "RFC 2119 Normative Term Overuse Considered Harmful"
abbrev: Normative Overuse Harmful
docname: draft-ietf-rtcweb-video-05
date: 2015-06-10
category: info
ipr: trust200902

coding: us-ascii

pi:
  toc: yes
  sortrefs: yes
  symrefs: yes

author:
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
  RFC2119:


informative:


--- abstract

Abstract

--- middle



Introduction
============

Introduction

Terminology
===========

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be
interpreted as described in {{RFC2119}}.

The English words "must", "required", "shall", "should", "recommended", "may",
"optional", and "not" in this document are to be interpreted as conveying their
ordinary, well-understood meanings.

Barry Leiba: "These words may also appear in this document in lower case as
plain English words, absent their normative meanings."

Clarification
=============

{{RFC2119}} itself cautions that "Imperatives of the type defined in this memo
must be used with care and sparingly."

Barry Leiba: "The trouble with the "non-normative synonyms" is that it makes
document text awkward, by requiring us to artificially substitute less apt
words, when "may" and "should", as English words, are exactly what we mean."

Randy Bush: "[D]o we not already have enough problems being clear and concise
without removing common words from our language?"

Security Considerations
=======================

The overuse of {{RFC2119}} normative terms can lead to reader fatigue, which can
cause implementors to overlook actually important implementation requirements.
Some of these requirements may be security related.

IANA Considerations
===================

This document requires no actions from IANA.


Acknowledgements
================
Randy Bush, David Cridland, Barry Leiba, Tony Hansen, Dave Crocker, and -- of course -- Scott Bradner.
draft-hansen-nonkeywords-non2119-02
