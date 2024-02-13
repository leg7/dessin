#pragma once
#include <vector>
#include <memory>
#include "Instruction.h"
#include "expressions/Expression.h"

class Branchement: public Instruction
{
	std::shared_ptr<Expression> _condition;
	std::vector<Instruction> _then;
	std::vector<Instruction> _else;
	public:
	// Branchement()
};
