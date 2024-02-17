#pragma once
#include "Instruction.h"
#include "../expressions/Expression.h"
#include <memory>
#include <vector>

class Boucle: public Instruction
{
	std::shared_ptr<Expression> _condition;
	std::vector<Instruction> _then;
	public:
	Boucle(const std::shared_ptr<Contexte> &c,
		const std::shared_ptr<Expression> &cond,
		const std::vector<Instruction> &then) noexcept:
			Instruction(c), _condition(cond), _then(then) {}

	virtual void executer() const noexcept override;
};
