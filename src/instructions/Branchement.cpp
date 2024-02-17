#include "Branchement.h"
#include <algorithm>

void Branchement::executer() const noexcept
{
	if (_condition->eval()->toDouble()) {
		for (const auto &it: _then) {
			it.executer();
		}
	} else {
		for (const auto &it: _else) {
			it.executer();
		}
	}
}
