#include "Ast.h"

void Ast::executer() const noexcept
{
	for (const auto &it: _data) {
		it->executer();
	}
}
