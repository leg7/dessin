#pragma once
#include "../Contexte.h"

class Instruction
{
	protected:
	std::shared_ptr<Contexte> _contexte;

	public:
	Instruction(const std::shared_ptr<Contexte> &c): _contexte(c) {}
	virtual void executer() const = 0;
};
