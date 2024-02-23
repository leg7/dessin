#pragma once
#include "Instruction.h"
#include "../expressions/Expression.h"
#include <memory>
#include <vector>

class Boucle: public Instruction
{
	std::shared_ptr<Expression> _condition;
	std::vector<std::shared_ptr<Instruction>> _then;
	public:
	Boucle(const std::shared_ptr<Contexte> &c,
		const std::shared_ptr<Expression> &cond,
		const std::vector<std::shared_ptr<Instruction>> &then) noexcept:
			Instruction(c), _condition(cond), _then(then) {}
	// TODO: constructeur sans cond mais entier pour boucle for

	virtual void executer() const noexcept override;
};
