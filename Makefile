
CC = i686-w64-mingw32-gcc
CXX = i686-w64-mingw32-g++
AR = i686-w64-mingw32-ar
ASM = nasm
WINDRES = i686-w64-mingw32-windres
#CFLAGS += -O0 -g
# GIT_HASH = $(shell git rev-parse --short HEAD)
GIT_HASH = nothing
CUR_TIME = $(shell date +%s)
ASMFLAGS += -fwin32 -DWIN32
CFLAGS += -O0 -gstabs -mms-bitfields -mabi=ms
CFLAGS += -Wall -Wno-unused-value -Wno-format -fpermissive -I. -I.. -DGIT_HASH=L\"$(GIT_HASH)\" -DCUR_TIME=L\"$(CUR_TIME)\" -DNDEBUG -DWIN32 -D_WIN32 -D_WINDOWS 
CFLAGS += -DKAGPARSER_EXPORTS -D_USRDLL -DMINGW_HAS_SECURE_API -DUNICODE -D_UNICODE -DNO_STRICT -DCMAKE_INTDIR=\"Release\"   
LDFLAGS += -shared -static -static-libstdc++ -static-libgcc -municode
LDLIBS += 

%.o: %.c
	echo -e "\tCC  $<"
	$(CC) -c $(CFLAGS) -o $@ $<

%.o: %.cpp
	echo -e "\tCXX  $<"
	$(CXX) -c $(CFLAGS) -o $@ $<

%.o: %.asm
	echo -e "\ASM  $<"
	$(ASM) $(ASMFLAGS) $< -o$@ 

%.o: %.rc
	echo -e "\tWINDRES  $<"
	$(WINDRES) --codepage=65001 $< $@

SOURCES := Main.cpp KAGParser.cpp ../tp_stub.cpp
OBJECTS := $(SOURCES:.c=.o)
OBJECTS := $(OBJECTS:.cpp=.o)
OBJECTS := $(OBJECTS:.asm=.o)
OBJECTS := $(OBJECTS:.rc=.o)

BINARY ?= KAGParser.dll
ARCHIVE ?= KAGParser.$(GIT_HASH).7z

all: $(BINARY)

archive: $(ARCHIVE)

clean:
	rm -f $(OBJECTS) $(BINARY) $(ARCHIVE)

$(ARCHIVE): $(BINARY) 
	rm -f $(ARCHIVE)
	7z a $@ $^

$(BINARY): $(OBJECTS) 
	@echo -e "\tLNK $@"
	$(CXX) $(CFLAGS) $(LDFLAGS)  -o $@ $^  $(LDLIBS)
