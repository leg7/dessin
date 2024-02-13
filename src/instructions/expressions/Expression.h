#pragma once
#include "../Instruction.h"

class Expression: public Instruction
{
	public:
	virtual int calculer() const noexcept = 0;
};
