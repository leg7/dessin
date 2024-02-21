#include "Affectation.h"

void Affectation::executer() const noexcept
{
	_contexte->add(_nom, _elem);
}
