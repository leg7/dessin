#pragma once
#include "Instruction.h"
#include "../Contexte.h"
#include "../expressions/Expression.h"
#include "../elements/ElementPrimitif.h"
#include <memory>

class Affectation: public Instruction
{
	std::shared_ptr<Contexte> _contexte;
	std::string _nom;
	std::shared_ptr<Expression> _expr;

	public:
	Affectation(const std::shared_ptr<Contexte> &contexte, const std::string &nom, const std::shared_ptr<Expression> &expr): _nom(nom), _contexte(contexte), _expr(expr) {}
	virtual void executer() const noexcept override;
};
