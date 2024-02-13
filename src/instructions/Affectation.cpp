#include "Affectation.h"

// TODO
void Affectation::executer() const noexcept
{
	_contexte->add(_nom, _expr->calculer());
}
