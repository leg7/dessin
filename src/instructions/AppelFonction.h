#pragma once
#include "Instruction.h"
#include "../Contexte.h"
#include <vector>

class AppelFonction: public Instruction
{
	std::vector<Instruction> _then;
	public:
	AppelFonction(const std::shared_ptr<Contexte> &c, const std::vector<Instruction> &then) noexcept: Instruction(c), _then(then) {}
	virtual void executer() const noexcept override;
};
