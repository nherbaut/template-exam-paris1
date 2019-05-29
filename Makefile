.DEFAULT_GOAL := exam
YEAR=2018-2019
COURSE=DEVWEB
DATE=

bootstrap:
	mkdir ./build

clean:
	rm -rf ./build/
	latexmk -c
	
exam: clean bootstrap
	latexmk  -pdf -jobname=build/exam_$(COURSE)_$(YEAR) exam.tex

solution: clean bootstrap
	latexmk  	-pdf \
				-jobname=build/solution_$(COURSE)_$(YEAR) \
				--pdflatex="/usr/bin/pdflatex --file-line-error --shell-escape --synctex=1 %O '\def\issolution{1}\input{%S}'"\
				exam.tex
	evince build/solution_$(COURSE)_$(YEAR).pdf &