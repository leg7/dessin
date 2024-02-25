#pragma once
#include "instructions/Instruction.h"
#include <vector>
#include <memory>

class Ast
{
	std::vector<std::shared_ptr<Instruction>> _data;
	public:
	void add(const std::shared_ptr<Instruction> &_i) noexcept;
	void executer() const noexcept;
};
