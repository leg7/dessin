#include "Declaration.h"

void Declaration::ajouterAuContexte(Contexte &c) const noexcept
{
	c.add(_nom, _val);
};

// TODO
void Declaration::executer() const noexcept
{
}

