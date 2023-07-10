SOURCE  = \
        draft-huque-dnsop-multi-alg-rules
DSTDIR=Revisions
VER=$(shell cat ${SOURCE}.xml | grep 'docName' | awk -F= '{print $$2}' | sed -e s'/"//g' | awk -F- '{print $$NF}')
VERP=$(shell expr ${VER} - 1)
VERQ=$(shell printf '%02d' ${VERP})

.PHONY: rfcdiff


all:	${DSTDIR}/$(SOURCE)-${VER}.txt ${DSTDIR}/$(SOURCE)-${VER}.html

${DSTDIR}/$(SOURCE)-${VER}.txt:	$(SOURCE).xml
	@mkdir -p $$(dirname $@)
	xml2rfc $(SOURCE).xml -n --text -o $@

${DSTDIR}/$(SOURCE)-${VER}.html:	$(SOURCE).xml
	@mkdir -p $$(dirname $@)
	xml2rfc $(SOURCE).xml -n --html -o $@

rfcdiff: ${DSTDIR}/$(SOURCE)-${VER}.txt
	bash ./rfcdiff ${DSTDIR}/$(SOURCE)-${VERQ}.txt ${DSTDIR}/$(SOURCE)-${VER}.txt ${DSTDIR}/${SOURCE}-${VER}-from-${VERQ}.diff.html

clean:
	rm -rf ${DSTDIR}/$(SOURCE)-${VER}.txt ${DSTDIR}/$(SOURCE)-${VER}.html
