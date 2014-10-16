BASENAME=visualservo
OUTDIR=compiled

export BIBINPUTS=.:${CURDIR}
export BSTINPUTS=.:${CURDIR}

all:
	mkdir -p ${OUTDIR}
	latex --interaction=nonstopmode -output-directory=${OUTDIR} ${BASENAME}.tex
	cd ${OUTDIR}; bibtex ${BASENAME}
	latex --interaction=nonstopmode -output-directory=${OUTDIR} ${BASENAME}.tex
	latex --interaction=nonstopmode -output-directory=${OUTDIR} ${BASENAME}.tex
	dvips ${OUTDIR}/${BASENAME}.dvi -o ${OUTDIR}/${BASENAME}.ps
	ps2pdf ${OUTDIR}/${BASENAME}.ps
