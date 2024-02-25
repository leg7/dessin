#pragma once
#include <vector>
#include <memory>
#include "Instruction.h"
#include "../expressions/Expression.h"

class Branchement: public Instruction
{
	std::shared_ptr<Expression> _condition;
	std::vector<std::shared_ptr<Instruction>> _then;
	std::vector<std::shared_ptr<Instruction>> _else;
	public:
	Branchement(const std::shared_ptr<Contexte> &c,
			const std::shared_ptr<Expression> &cond,
			const std::vector<std::shared_ptr<Instruction>> &then,
			const std::vector<std::shared_ptr<Instruction>> &not_then = {}) noexcept:
		Instruction(c), _condition(cond), _then(then), _else(not_then) {}

	virtual void executer() const noexcept override;
};
