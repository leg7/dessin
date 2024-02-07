#include "instructions/Instruction.h"
#include <vector>
#include <memory>

class Ast
{
	std::vector<std::shared_ptr<Instruction>> data;
};
