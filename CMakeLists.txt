cmake_minimum_required(VERSION 3.18.0)

project(dessin)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED on)
set(CMAKE_CXX_EXTENSIONS off)
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    add_compile_options(-Wall -Wpedantic)
endif()

find_package(BISON)
find_package(FLEX)

include_directories(src/ast src/lexer-parser ${CMAKE_CURRENT_BINARY_DIR})
file(GLOB_RECURSE AST_HEADERS "src/ast/*.hh" "src/ast/*.h")
file(GLOB_RECURSE AST_SOURCES "src/ast/*.cpp")

add_library(ast
	${AST_HEADERS}
	${AST_SOURCES}
    )

BISON_TARGET(parser src/lexer-parser/parser.yy ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp VERBOSE ${CMAKE_CURRENT_BINARY_DIR}/automate.txt)
FLEX_TARGET(scanner src/lexer-parser/scanner.ll  ${CMAKE_CURRENT_BINARY_DIR}/scanner.cpp)
ADD_FLEX_BISON_DEPENDENCY(scanner parser)
add_executable(${PROJECT_NAME}
    src/lexer-parser/main.cpp
	src/lexer-parser/Driver.h
	src/lexer-parser/Driver.cpp
    src/lexer-parser/scanner.hh
    src/lexer-parser/scanner.ll
    src/lexer-parser/parser.yy
    ${BISON_parser_OUTPUTS}
    ${FLEX_scanner_OUTPUTS}
)
target_link_libraries(${PROJECT_NAME} ast)

target_link_libraries(ast)
