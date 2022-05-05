
TARGET_NAMES = main hello

# PROJECT
PROJECT_CURRENT_PATH = ${PWD}

CC = gcc

# compiler
#
# CC = arm-linux-gnueabihf-gcc
# CPP = arm-linux-gnueabihf-g++
# AR = arm-linux-gnueabihf-ar

COM_FLAGS = -Wall -O2 -g
C_FLAGS   = $(COM_FLAGS) -std=c11
CPP_FLAGS = $(COM_FLAGS) -std=c++11

C_INCLUDES = 

C_SOURCES = 

C_OBJECTS = $(patsubst %.c, %.o, ${C_SOURCES})

C_LIBS += -L. \
					

.PHONY: all before_build after_build debug release clean ${TARGET_NAMES}

all: before_build debug after_build 

before_build: 
	@echo " **************** ${@} ****************"
	@echo C_INCLUDES: ${C_INCLUDES}
	@echo C_SOURCES: ${C_SOURCES}
	@echo C_OBJECTS: ${C_OBJECTS}
	@echo C_LIBS: ${C_LIBS}

after_build: 
	@echo " **************** ${@} ****************"

# debug: C_FLAGS+=-g
debug: ${TARGET_NAMES}

release: ${TARGET_NAMES}

${TARGET_NAMES}: %: %.o ${C_OBJECTS}
	@echo " **************** ${@} ****************"
	${CC} -o $@ $^ ${C_FLAGS}

%.o: %.c
	${CC} -c -o $@ $^ ${C_FLAGS}

clean:
	${RM} ${TARGET_NAMES}
	${RM} *.o
	${RM} ${C_OBJECTS}

