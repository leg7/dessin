#pragma once
#include "instructions/Instruction.h"
#include <vector>
#include <memory>

class Ast
{
	std::vector<std::shared_ptr<Instruction>> _data;
	public:
	void executer() const noexcept;
};
