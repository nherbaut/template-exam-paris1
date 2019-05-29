.DEFAULT_GOAL := all
.PHONY := all bootstrap clean dist
YEAR=2018-2019
FILENAME=DEVWEB
COURSENAME=Développement WEB --- Session 2
CURICULUM=L2 MIASHS Renforcement Informatique
DURATION=1h30
DATE=26 Juin 2019
PROFNAME=Nicolas Herbaut
Makefile: ;

all: clean exam solution dist;

bootstrap:
	@mkdir -p ./build

clean:
	@latexmk -c
	@rm -rf ./build/*

dist: 
	@find ./build/ -type f ! -name '*.pdf' -delete
	
%: bootstrap 
	latexmk  	-pdf \
				-jobname=build/$@_$(FILENAME)_$(YEAR) \
				--pdflatex="/usr/bin/pdflatex --file-line-error --shell-escape --synctex=1 %O '\def\examDate{$(DATE)}\def\duration{$(DURATION)}\def\courseName{$(COURSENAME)}\def\curiculum{$(CURICULUM)}\def\profname{$(PROFNAME)}\def\is$@{1}\input{%S}'"\
				exam.tex
	evince build/$@_$(FILENAME)_$(YEAR).pdf &

