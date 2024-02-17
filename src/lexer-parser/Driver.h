#pragma once

#include "../Ast.h"

class Driver {
	public:
	Ast ast;
	Driver(const Ast &a) noexcept: ast(a) {}
};
