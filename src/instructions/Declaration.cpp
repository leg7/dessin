#include "Declaration.h"

void Declaration::executer() const noexcept
{
	_contexte->add(_nom, _val);
}

