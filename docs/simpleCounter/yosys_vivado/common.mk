TOP := $(strip ${TOP})
TARGET := $(strip ${TARGET})

BUILDDIR := ${current_dir}/build
BOARD_BUILDDIR := ${BUILDDIR}/${TARGET}

# Set board properties based on TARGET variable
ifeq ($(TARGET),arty_35)
DEVICE := xc7a50t_test
BITSTREAM_DEVICE := artix7
PARTNAME := xc7a35tcsg324-1
else ifeq ($(TARGET),arty_100)
DEVICE := xc7a100t_test
BITSTREAM_DEVICE := artix7
PARTNAME := xc7a100tcsg324-1
else ifeq ($(TARGET),nexys4ddr)
DEVICE := xc7a100t_test
BITSTREAM_DEVICE := artix7
PARTNAME := xc7a100tcsg324-1
else ifeq ($(TARGET),zybo)
DEVICE := xc7z010_test
BITSTREAM_DEVICE := zynq7
PARTNAME := xc7z010clg400-1
else ifeq ($(TARGET),nexys_video)
DEVICE := xc7a200t_test
BITSTREAM_DEVICE := artix7
PARTNAME := xc7a200tsbg484-1
else ifeq ($(TARGET),basys3)
DEVICE := xc7a50t_test
BITSTREAM_DEVICE := artix7
PARTNAME := xc7a35tcpg236-1
else
$(error Unsupported board type)
endif

# Determine the type of constraint being used
ifneq (${XDC},)
XDC_CMD := -x ${XDC}
endif
ifneq (${SDC},)
SDC_CMD := -s ${SDC}
endif
ifneq (${PCF},)
PCF_CMD := -p ${PCF}
endif

.DELETE_ON_ERROR:

# Build design
all: ${BOARD_BUILDDIR}/${TOP}.eblif

${BOARD_BUILDDIR}:
	mkdir -p ${BOARD_BUILDDIR}

${BOARD_BUILDDIR}/${TOP}.eblif: ${SOURCES} ${XDC} ${SDC} ${PCF} | ${BOARD_BUILDDIR}
	cd ${BOARD_BUILDDIR} && symbiflow_synth -t ${TOP} -v ${SOURCES} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} ${XDC_CMD} 2>&1 > /dev/null
	python3 ${TMR_SCRIPT} ${BOARD_BUILDDIR}/${TOP}.eblif ${CONSTRAINT_NEW}
	
clean:
	rm -rf ${BUILDDIR}


