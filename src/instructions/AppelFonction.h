#pragma once
#include "Instruction.h"
#include "../Contexte.h"
#include <vector>

class AppelFonction: public Instruction
{
	Contexte _contexte;
	std::vector<Instruction> _then;
	public:
	AppelFonction(const Contexte &c, const std::vector<Instruction> &then) noexcept: _contexte(c), _then(then) {}
	virtual void executer() const noexcept override;
};
