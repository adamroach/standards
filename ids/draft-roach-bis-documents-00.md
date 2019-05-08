---
title: "Process for Handling Non-Major Revisions to Existing RFCs"
abbrev: "Minor -bis Document Process"
docname:  draft-roach-bis-documents-00
date: 2019-05-07
category: bcp
ipr: trust200902

stand_alone: yes
pi: [toc, sortrefs, symrefs]

author:
-
    ins: A.B. Roach
    name: Adam Roach
    org: Mozilla
    email: adam@nostrum.com

normative:
  RFC2026:
  RFC2119:
  RFC8174:

informative:
  RFC8540:
  RFC8035:
  RFC7647:


--- abstract

This document discusses mechanisms the IETF has historically used for
updating RFCs subsequent to their publication, and outlines an updated
procedure for publishing newer versions (colloquially known as "bis
versions") that is appropriate in certain circumstances. This procedure
is expected to be easier for both authors and consumers of RFCs.

--- middle

# Introduction {#sec-introduction}

{{RFC2026}} defines the Internet Standards Process, largely focusing on the
handling of the RFC publication process.  Part of this process as originally
envisioned includes republication of documents under a number of
circumstances, such as when a document is progressed towards Internet Standard
status. The circumstances that necessitated republication originally
also included various fixes to the contents of the documents; for example,
RFC 2026 specifies:

~~~~~~~~~~
   [A]n important typographical error, or a technical error that does
   not represent a change in overall function of the specification,
   may need to be corrected immediately.  In such cases, the IESG or
   RFC Editor may be asked to republish the RFC (with a new number)
   with corrections...
~~~~~~~~~~

In the intervening years since the publication of RFC 2026, various
additional mechanisms have emerged to deal with minor updates to
existing, published RFCs. The RFC Editor maintains a set
of errata associated with published documents. These errata are intended
for use when the intention of the document can be deduced, but the
expression of the intention is imperfect (e.g., it contains a
typographical error or is ambiguous in its phrasing). Notably, errata
cannot be used to change the intended meaning of a document from
that which was originally intended.

Additionally, it is increasingly common to publish new, relatively small RFCs
whose sole purpose is to update the functioning of an existing RFC. Such
documents are frequently formatted in a way that specifies an original text
block that is to be replaced with a new text block. In some cases, such as
{{RFC8035}}, these documents contain a single straightforward update. In
others, such as {{RFC8540}}, several updates are bundled together in a single
document.  It should be noted that not all such updates are defined in a form
that specifies old-text/new-text blocks; for example, {{RFC7647}} describes
updates to an existing document in simple prose, but it is semantically the
same as documents that perform text replacement.

An unfortunate consequence of this approach to updating RFCs is that consumers
of such documents are left with no authoritative, correct version of a
document.  Instead, they must read the base document, and then mentally
apply the updates specified by each successor document that has updated it in
this fashion. As a secondary concern, the production of such documents is
complicated by the need for authors, contributors, and reviewers to flip
back-and-forth between the base document and the updating document; and if
multiple RFCs update a base document in sequence, this problem is compounded
even further.

One major concern that drives these incremental document updates is
that an attempt to republish an RFC as originally described in RFC 2026
can result in such an effort being bogged down by issues that exist
in text unrelated to the desired changes. Such issues can arise from
a change in the consensus of the IETF around best current practices,
such as in the areas of security, privacy, or architectural design of
an underlying protocol. This complication arises from the fact that
processing of an updated full version of an RFC is procedurally identical
to processing of a green-field definition of a new protocol: review by
the IETF at large, and review by the IESG, are performed on the entire
document, leaving legacy text open to comments that will delay -- and
occasionally block -- publication of such documents.

In order to address this concern, this document proposes new guidelines
intended to reduce the barriers to publication of updated documents, and
to reduce the load on reviewers during IETF and IESG review.

# Terminology

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED",
"MAY", and "OPTIONAL" in this document are to be interpreted as
described in BCP 14 {{RFC2119}} {{RFC8174}} when, and only when, they
appear in all capitals, as shown here.

# Processing for Revised Documents

At a high level, the process described in this document allows
bis versions of documents to be processed along with a request to
review teams, directorates, the IETF community, and the IESG
that any reviews primarily take into consideration the changes
to the document, rather than the document as a whole. While these
requests do not strictly preclude feedback and discussion of the
unchanged portions of bis documents, reviewers are expected to
take them under serious consideration.

Note that the process described in this document exclusively considers
IETF-stream documents.

## Basic Qualifications {#sec-qualifications}

In order to be considered for the processing described in this document,
a bis update needs to satisfy the following criteria:

1. The document must formally obsolete (not update) an existing RFC.

2. The changes from the document being obsoleted must not constitute
   the majority of the document. This is a subjective evaluation,
   not a mathematical one.

3. Except as detailed in verified errata, the document does not contain
   spurious changes (such as reformatting) in sections other than those
   containing substantive updates.

4. The document SHOULD contain an appendix detailing the changes from the
   RFC it is replacing. Any change for which the rationale is not
   abundantly obvious should be explained in this appendix.

5. The publication track of the new document MUST be the same as the
   document that is being replaced (for example, the process cannot
   be used when obsoleting an Experimental document with a Standards
   Track one)

6. The AD sponsoring the document must explicitly approve the use of
   the process described in this document.

Although not a strict qualification, working groups and authors of documents
using this process should carefully evaluate all verified errata on the
original RFC and all RFCs that formally update the original RFC to determine
which, if any, the new document should incorporate.

## Document Evaluation Process

When an author or working group wish to request publication of a bis document
with targeted review of limited changes, the following considerations are
applied.

1. The shepherd's write-up includes a statement indicating that the
   qualifications outlined in {{sec-qualifications}}
   are satisfied, and asking for the processing described in this document.

2. The "Last-Call notification" that is specified by RFC 2026 section
   6.1.2 will include a prominent notification stating: "This document is
   being published according to the process defined in RFC XXXX. While reading
   the entire contents of the document will provide useful context to
   reviewers, the IESG is primarily soliciting input regarding the changed
   portions of the document at this time".

3. The "Last-Call notification" MUST also include a pointer to a
   mechanically-generated diff file that exhaustively indicates the changes
   between the bis document and the document it is obsoleting.

4. As part of the IESG's evaluation of the document, its sponsoring AD will
   communicate to the IESG that processing is requested according to the
   procedures in this document. This communication will request that the IESG
   focus on the changes from the obsoleted RFC. IESG members SHOULD NOT issue
   DISCUSS or ABSTAIN ballot positions based on unchanged text except as
   described in {{sec-deprecated}}.  In the rare case that such positions are
   balloted, they need to balance the scope of changes between existing RFC
   and bis document against the amount of work required to address potential
   comments.


## Deprecated Technology {#sec-deprecated}

One major change that results from the application of the procedure described
in this document is that the IETF may re-publish older text that describes
approaches to protocol design that are no longer considered safe, advisable,
or appropriate. To avoid this re-publication implying an endorsement by the
IETF of such deprecated approaches, they MUST be clearly indicated in the
"Introduction" section of the document using the following text or text
substantially similar to it:

~~~~~~~~~~
  This document is a revision of a previously published RFC. Some
  portions of the text have not been updated and do not meet current
  best practices for documents published by the IETF.
~~~~~~~~~~

The introduction must then detail each specific technique in the document
that would not generally be acceptable in newly-published specifications.

Notably, this text might be added by the working group during development
of the revision, as a result of IETF Last-Call or directorate reviews, or
as part of the IESG evaluation process. The need for such a notice is
explicitly considered an acceptable rationale for an IESG member to hold
a blocking position on a document ballot.


# Implications for Other Documents

To avoid those usability issues described in {{sec-introduction}}, IETF-stream
documents generally SHOULD NOT perform updates to existing RFCs by replacing
text in such RFCs (either syntactically via "OLD TEXT"/"NEW TEXT" sections, or
semantically by describing changes to protocol processing). Instead, such
updates should be performed by publishing new versions of existing RFCs. Note
that such new versions do not necessarily need to make use of the process
described in this document.

There may be exceptional circumstances that warrant simple text replacement
rather than new document versions.  These cases should be rare and carefully
considered; and documents that do so should contain text explaining why the
publication of a new version of the updated document is not desirable.

# To-Do

* The text uses phrasing like "the process described in this document" in
  several places. This is cumbersome. Ideally, we would come up with a short
  term of art to describe this process.

# IANA Considerations {#sec-iana}

This document makes no requests of IANA. Authors of documents that use this
process should carefully examine the "IANA Considerations" sections of the
document they are obsoleting, and ensure that any IANA data pointing to the
obsoleted document is updated to instead indicate the new document.

# Security Considerations {#sec-security}

As stated in {{sec-deprecated}}, this process may result in the
re-publication of techniques, including security techniques, that
are no longer considered safe. During development of a bis document,
authors and working groups are strongly encouraged to update such
outmoded security approaches in favor of more modern ones.

It should be noted that, while the process introduced by this document
does not necessarily improve this situation, it is carefully designed
to also not exacerbate the status quo. Absent this process, the
historical approach of issuing documents that update small portions
of older RFCs would continue, and such outmoded security techniques
would remain equally in effect.

#  Acknowledgments {#sec-acknowledgments}
Thanks to Ben Campbell and Joe Hildebrand for early conversations that helped
inform the contents of this document, and to the 2019 members of the IESG for
helping to refine some of the more subtle points of handling deprecated
approaches.
