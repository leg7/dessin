cmake_minimum_required(VERSION 3.10.0)
project(bison_expressions)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED on)
set(CMAKE_CXX_EXTENSIONS off)
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    add_compile_options(-Wall -Wpedantic)
endif()

find_package(BISON)
find_package(FLEX)


include_directories(parser expressions ${CMAKE_CURRENT_BINARY_DIR})
file(GLOB EXPRESSION_HEADERS
	src/elements/Couleur.cpp
	src/elements/formes/Chemin.cpp
	src/elements/formes/Rectangle.cpp
	src/instructions/Branchement.cpp
	src/instructions/Declaration.cpp
	src/instructions/Affectation.cpp
	src/instructions/Boucle.cpp
	src/instructions/AppelFonction.cpp
	src/lexer-parser/main.cpp
	src/lexer-parser/Driver.cpp
	src/Ast.cpp
	src/expressions/ExpressionBinaire.cpp
	src/expressions/ExpressionUnaire.cpp
	src/Contexte.cpp
)

add_library(expressions
	src/elements/Couleur.cpp
	src/elements/formes/Chemin.cpp
	src/elements/formes/Rectangle.cpp
	src/instructions/Branchement.cpp
	src/instructions/Declaration.cpp
	src/instructions/Affectation.cpp
	src/instructions/Boucle.cpp
	src/instructions/AppelFonction.cpp
	src/lexer-parser/main.cpp
	src/lexer-parser/Driver.cpp
	src/Ast.cpp
	src/expressions/ExpressionBinaire.cpp
	src/expressions/ExpressionUnaire.cpp
	src/Contexte.cpp
	${EXPRESSION_HEADERS}
)

BISON_TARGET(parser parser/parser.yy ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp VERBOSE ${CMAKE_CURRENT_BINARY_DIR}/automate.txt)
FLEX_TARGET(scanner parser/scanner.ll  ${CMAKE_CURRENT_BINARY_DIR}/scanner.cpp)
ADD_FLEX_BISON_DEPENDENCY(scanner parser)
add_executable(${PROJECT_NAME}
    src/lexer-parser/main.cpp
    src/lexer-parser/Driver.h
    src/lexer-parser/Driver.cpp
    src/lexer-parser/scanner.h
    src/lexer-parser/scanner.ll
    src/lexer-parser/parser.yy
    ${BISON_parser_OUTPUTS}
    ${FLEX_scanner_OUTPUTS}
)
target_link_libraries(${PROJECT_NAME} expressions)

add_executable(dessin src/lexer-parser/main.cpp)
target_link_libraries(dessin expressions)
