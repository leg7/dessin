#include "AppelFonction.h"

void AppelFonction::executer() const noexcept
{
	for (const auto &it: _then) {
		it->executer();
	}
}
