#include "Ast.h"

void Ast::executer() const noexcept
{
	for (const auto &it: _data) {
		it->executer();
	}
}

void Ast::add(std::shared_ptr<Instruction> _i) noexcept
{
	_data.push_back(_i);
}
