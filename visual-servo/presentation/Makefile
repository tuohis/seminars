BASENAME=visualservo_slides
OUTDIR=compiled

export TEXINPUTS=.:${CURDIR}/beamerthemes:

all:
	mkdir -p ${OUTDIR}
	pdflatex --interaction=nonstopmode -output-directory=${OUTDIR} ${BASENAME}.tex
	pdflatex --interaction=nonstopmode -output-directory=${OUTDIR} ${BASENAME}.tex
	mv ${OUTDIR}/${BASENAME}.pdf ./
