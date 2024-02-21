#pragma once

#include "../Ast.h"
#include <memory>

class Driver {
	public:
	Ast ast;
	std::shared_ptr<Contexte> contexteCourant;
	Driver() noexcept: contexteCourant(std::make_shared<Contexte>()) {}
};
