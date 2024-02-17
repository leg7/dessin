#pragma once
#include <vector>
#include <memory>
#include "Instruction.h"
#include "../expressions/Expression.h"

class Branchement: public Instruction
{
	std::shared_ptr<Expression> _condition;
	std::vector<Instruction> _then;
	std::vector<Instruction> _else;
	public:
	Branchement(const std::shared_ptr<Expression> &cond, const std::vector<Instruction> &then, const std::vector<Instruction> &not_then): _condition(cond), _then(then), _else(not_then) {}
	virtual void executer() const noexcept override;
};
