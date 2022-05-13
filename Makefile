

# PROJECT
PROJECT_ROOT_PATH = ${PWD}
TARGET_NAMES = main hello

# compiler
ifeq (${ARHC},arm)
CC = arm-linux-gnueabihf-gcc
CPP = arm-linux-gnueabihf-g++
AR = arm-linux-gnueabihf-ar
else 
CC = gcc
endif

COM_FLAGS = -Wall -O2 -g
C_FLAGS   = $(COM_FLAGS) -std=c11
CPP_FLAGS = $(COM_FLAGS) -std=c++11

# includes

C_SRCS += 

C_OBJS = $(patsubst %.c, %.o, ${C_SRCS})

C_LIBS += -L. \

C_FLAGS += ${C_LIBS} 

.PHONY: all before_build after_build debug release clean ${TARGET_NAMES}

all: before_build debug after_build 

before_build: 
	@echo "====> ${@}"
	@echo C_SRCS: ${C_SRCS}
	@echo C_OBJS: ${C_OBJS}
	@echo C_LIBS: ${C_LIBS}
	@echo VPATH: ${VPATH}

after_build: 
	@echo ""
	@echo "====> ${@}"

# debug: C_FLAGS+=-g
debug: ${TARGET_NAMES}

release: ${TARGET_NAMES}

${TARGET_NAMES}: %: %.o ${C_OBJS}
	@echo ""
	@echo "====> ${@} "
	${CC} ${C_FLAGS} -o $@ $<  

%.o: %.c
	${CC} ${C_FLAGS} -c -o $@ $< 

clean:
	${RM} ${TARGET_NAMES}
	${RM} *.o
	${RM} ${C_OBJS}

