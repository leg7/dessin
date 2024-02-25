#pragma once
#include "../Contexte.h"

class Instruction
{
	public:
	std::shared_ptr<Contexte> _contexte;

	Instruction(const std::shared_ptr<Contexte> &c): _contexte(c) {}
	virtual void executer() const = 0;
};
