cmake_minimum_required(VERSION 3.9)
project(hello_world)

set(CMAKE_CXX_STANDARD 11)

#---------------------------------------------------------------------
# get build config from aocl command
#---------------------------------------------------------------------
find_program(AOCL_FOUND aocl)
if (NOT AOCL_FOUND)
    message(FATAL_ERROR "Executable 'aocl' not found. Setup AOC environment.")
endif ()
execute_process(
        COMMAND aocl compile-config
        OUTPUT_VARIABLE AOCL_COMPILE_OPTIONS
        OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(
        COMMAND aocl link-config
        OUTPUT_VARIABLE AOCL_LINK_OPTIONS
        OUTPUT_STRIP_TRAILING_WHITESPACE
)

include_directories(common/inc)

set(TARGET hello_world)
add_executable(${TARGET}
        hello_world/host/src/main.cpp
        common/src/AOCLUtils/opencl.cpp
        common/src/AOCLUtils/options.cpp)
target_compile_options(${TARGET} PRIVATE ${AOCL_COMPILE_OPTIONS})
target_link_libraries(${TARGET} PRIVATE ${AOCL_LINK_OPTIONS} rt pthread)