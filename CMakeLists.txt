cmake_minimum_required(VERSION 3.10)
project(dessin)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
add_compile_options(-Wall -Wpedantic)

find_package(BISON)
find_package(FLEX)
BISON_TARGET(MyParser src/lexer-parser/parser.yy ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp)
FLEX_TARGET(MyScanner src/lexer-parser/scanner.ll ${CMAKE_CURRENT_BINARY_DIR}/scanner.cpp)
# Add Bison and Flex generated files to the sources
set(GENERATED_FILES ${BISON_MyParser_OUTPUTS} ${FLEX_MyScanner_OUTPUTS})

# Collect all source files recursively
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.h" "src/*.hpp")

# Add the executable target
add_executable(dessin ${SOURCES} ${GENERATED_FILES})

