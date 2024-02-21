#include "parser.hpp"
#include "scanner.h"
#include "Driver.h"

#include <iostream>
#include <fstream>

#include <cstring>

int main( int  argc, char* argv[]) {
	Driver * driver = new Driver();
	Scanner * scanner = new Scanner(std::cin, std::cout);
	yy::Parser * parser = new yy::Parser(*scanner, *driver);

	parser->parse();

	return 0;
}
