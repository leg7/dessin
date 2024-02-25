#include "Driver.h"
#include "scanner.hh"

#include <iostream>
#include <fstream>

#include <cstring>


int main( int  argc, char* argv[]) {
	Driver * driver = new Driver();
	Scanner * scanner = new Scanner(std::cin, std::cout);
	yy::Parser * parser = new yy::Parser(*scanner, *driver);

	parser->parse();

	driver->ast.executer();
	// driver->contexteCourant->to_svg();
	std::cout << "done\n";

	return 0;
}
