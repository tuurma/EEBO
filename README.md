EEBO
====

##Summary .md files generator for TEI files##

###Sections###

*Header Summary
*Content Summary
*Tag Usage Summary

####Header Summary####

Header summary contains information harvested from teiHeader section of the document presented in human-readable form. High level elements eg fileDesc, profileDesc, encodingDesc are rendered as appropriate md headings using #

Some elements may get specific treatment to present data in traditional form (eg publicationStmt). Prose content is rendered as paragraphs. Structured content is rendered as lists.

####Content Summary####

Content summary is a table of contents for the document. Where no internal hierarchy is present, the incipit is given.

####Tag Usage Summary####

*element list and frequenty plus nested attribute lists (with frequency and possibly distinct values)
*special interest statistics
    - entities summary: listPerson, listPlace etc
    - transcriptional features summary (gaps, corrections, expansions, regularization etc)
    - critical apparatus summary (listWit, number of apparatus entries etc)
    - tbc

