.DEFAULT_GOAL := all
YEAR=2018-2019
COURSE=DEVWEB
DATE=26 Juin 2019

all: exam solution dist

bootstrap:
	@mkdir -p ./build

clean:
	@latexmk -c

dist: 
	@find ./build/ -type f ! -name '*.pdf' -delete
	
exam: clean bootstrap
	@latexmk  -pdf -jobname=build/$@_$(COURSE)_$(YEAR) exam.tex
	@evince build/$@_$(COURSE)_$(YEAR).pdf &

solution: clean bootstrap
	@latexmk  	-pdf \
				-jobname=build/$@_$(COURSE)_$(YEAR) \
				--pdflatex="/usr/bin/pdflatex --file-line-error --shell-escape --synctex=1 %O '\def\issolution{1}\def\examDate{$(DATE)}\input{%S}'"\
				exam.tex
	@evince build/$@_$(COURSE)_$(YEAR).pdf &