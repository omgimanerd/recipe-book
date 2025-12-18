# Makefile configuration for compiling this project.

.PHONY: all clean

all: output/recipe-book.pdf

# Main output PDF
output/recipe-book.pdf: recipe-book.tex
	@mkdir -p output
	@TEXINPUTS=.//:: latexmk -interaction=nonstopmode -f -pdf \
		-outdir=$(PWD)/output -auxdir=$(PWD)/output -out2dir=$(PWD)/output \
		$< >/dev/null 2>/dev/null

# File watcher
watch:
	@inotifywait -e modify -e create -m -r --include '.*\.tex$$' ./ | \
	while read -r directory action file; do \
		make; \
	done

clean:
	@rm -rf output/*
