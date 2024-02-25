#include "Boucle.h"

void Boucle::executer() const noexcept
{
	if (_forLoop) {
		auto iterations = static_cast<int>(_condition->eval()->toDouble());
		for (size_t i = 0; i < iterations; ++i) {
			for (const auto &it: _then) {
				it->executer();
			}
		}
	} else {
		while (_condition->eval()->toDouble()) {
			for (const auto &it: _then) {
				it->executer();
			}
		}
	}
}
