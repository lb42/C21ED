# C21ED

This repository contains TEI versions of the  interviews collected for James O'Sullivan's "21st C Editions", concerning which see  https://www.dhi.ac.uk/projects/c21editions/ and (my personal take) http://foxglove.hypotheses.org/779.

It also contains, in the folder `Scripts` the XSLT and shell scripts I used to effectuate the re-encoding. The pipeline was :

## grabit

Download and unzip the archive provided at the DHI site. Open each RTF file using a headless libreoffice and pipe it through the standard TEI docxtoTEI conversion.

## c21.xsl

Discard most of the TEI Header generated in the preceding step, and add some useful data extracted from known places in the content of the document. Move the brief bios temporarily to a `<front>` element. Identify all speaker prefixes and tag them as such, even though this makes the document invalid. Coping with multiple interviewees was a little tricky: I cheated by introducing a `<list>` in the two or three cases where there was more than one brief bio in a documenty. I also ought to go back and do something about the italicized and square bracketted segments in the original some time.

## c21x.xsl   

Improve on the output of the c21 stylesheet, chiefly by adding <sp> elements, and validate the results by loading them into TXM (which, as a bonus, adds lemmatization and POS tags)

## textOnly.xsl

Prepare simplified plain text files with appropriate filenames to suit the somewhat arbitrary exigencies of stylo. This process threw up a few inconsistencies in the way files and interviewees were identified, which I fixed.
The output is a file of plain text for each respondent, and another for each interviewer, containing all their remarks concatenated. 
