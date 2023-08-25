
cmake_minimum_required(VERSION 3.12)
project(KAGParser_krkrsdl2)

include(FetchContent)

FetchContent_Declare(
	krkrsdl2-tp_stub
	URL https://github.com/krkrsdl2/krkrsdl2/releases/download/latest/krkrsdl2-tp_stub.tar.gz
)

FetchContent_MakeAvailable(krkrsdl2-tp_stub)

set(KAGPARSER_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR})
file(STRINGS ${KAGPARSER_SRC_DIR}/src_list/sources.txt KAGPARSER_SRC)
list(TRANSFORM KAGPARSER_SRC PREPEND ${KAGPARSER_SRC_DIR}/)

add_library(KAGParser MODULE)
set_target_properties(KAGParser PROPERTIES CXX_STANDARD 11)
set_target_properties(KAGParser PROPERTIES PREFIX "")
target_sources(KAGParser PRIVATE ${KAGPARSER_SRC})
target_link_libraries(KAGParser tp_stub)

if(FALSE)
cmake_minimum_required(VERSION 3.4.1)

set( CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS}-Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/version_script.map -Wl,--strip-debug -Wl,--discard-all" )

include_directories( ./
             ../)

add_library( kagparser

             SHARED

             Main.cpp
             KAGParser.cpp
             ../tp_stub.cpp)

target_link_libraries( kagparser )
endif()

