#include "Boucle.h"

void Boucle::executer() const noexcept
{
	if (_condition->eval()->toDouble()) {
		for (const auto &it: _then) {
			it.executer();
		}
	}
}
