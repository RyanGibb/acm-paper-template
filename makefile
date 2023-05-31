.PHONY: all clean dist print

F = main

default : $F.pdf

$F.dvi	: $(wildcard *.tex *.bib figures/*.eps)
	latex  $F < /dev/null || $(RM) $@
	bibtex $F < /dev/null || $(RM) $@
	latex  $F < /dev/null || $(RM) $@
	latex  $F < /dev/null || $(RM) $@

$F.pdf  : $(wildcard *.tex *.bib figures/*)
	pdflatex --shell-escape $F
	bibtex $F
	pdflatex --shell-escape $F
	pdflatex --shell-escape $F

$F.ps	: $F.dvi
	dvips -tletter -Ppdf $F.dvi -o $F.ps

$F.ps.gz: $F.ps
	$(RM) $F.ps.gz
	gzip -9 < $F.ps > $F.ps.gz

print:	$F.ps

dist:	$F.ps.gz

clean:
	$(RM) $F.log $F.aux $F.bbl $F.blg $F.out $F.dvi $F.ps $F.ps.gz texput.log

deepclean: clean
	$(RM) $F.ps $F.pdf
