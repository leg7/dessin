#pragma once

#include <string>
#include <vector>
#include "../Ast.h"

class Driver {
	Ast _ast;
	public:
	Driver(const Ast &a) noexcept: _ast(a) {}
};
