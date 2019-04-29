#
# Author: Jake Zimmerman <jake@zimmerman.io>
#
# ===== Usage ================================================================
#
# NOTE:
#   When running these commands at the command line, replace $(TARGET) with
#   the actual value of the TARGET variable.
#
#
# make                  Compile all *.md files to PDFs
# make <filename>.pdf   Compile <filename>.md to a PDF
# make <filename>.tex   Generate the intermediate LaTeX for <filename>.md
#
# make view             Compile $(TARGET).md to a PDF, then view it
# make again            Force everything to recompile
#
# make clean            Get rid of all intermediate generated files
# make veryclean        Get rid of ALL generated files:
#
# make print            Send $(TARGET).pdf to the default printer:
#
# ============================================================================

TARGET=Swedish
BUILD_DIR=build

all: $(patsubst %.md,%.pdf,$(wildcard *.md))

PANDOC_FLAGS =\
	-r markdown \
	-s \
	--template template

LATEX_FLAGS = \

PDF_ENGINE = weasyprint
PANDOCVERSIONGTEQ2 := $(shell expr `pandoc --version | grep ^pandoc | sed 's/^.* //g' | cut -f1 -d.` \>= 2)
ifeq "$(PANDOCVERSIONGTEQ2)" "1"
    LATEX_FLAGS += --pdf-engine=$(PDF_ENGINE)
else
    LATEX_FLAGS += --latex-engine=$(PDF_ENGINE)
endif

all: $(patsubst %.md,%.pdf,$(wildcard *.md))

# Generalized rule: how to build a .pdf from each .md
%.pdf: %.md
	mkdir -p $(BUILD_DIR)
	cat "$(basename $<).yml" $< > "Compiled.md"
	pandoc $(PANDOC_FLAGS) $(LATEX_FLAGS) -o $(BUILD_DIR)/$@ "Compiled.md"

# Generalized rule: how to build a .tex from each .md
%.tex: %.md
	pandoc --standalone $(PANDOC_FLAGS) -o build/$@ $<

touch:
	touch *.md

again: touch all

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb || true
	rm -rf $(BUILD_DIR) || true

veryclean: clean
	rm -f *.pdf

view: $(TARGET).pdf
	if [ "Darwin" = "$(shell uname)" ]; then open $(TARGET).pdf ; else xdg-open $(TARGET).pdf ; fi

print: $(TARGET).pdf
	lpr $(TARGET).pdf

.PHONY: all again touch clean veryclean view print
