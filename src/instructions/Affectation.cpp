#include "Affectation.h"

Affectation::Affectation(const std::shared_ptr<Contexte> &contexte, const std::string &nom):
	Instruction(contexte), _nom(nom)
{
}

