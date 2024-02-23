#include "Affectation.h"
#include <stdexcept>

Affectation::Affectation(const std::shared_ptr<Contexte> &contexte, const std::string &nom, const std::shared_ptr<Element> &elem):
	Instruction(contexte), _nom(nom), _elem(elem)
{
}

void Affectation::executer() const
{
	if (!_contexte->contains(_nom)) {
		throw std::invalid_argument("Impossible d'affecter, la variable n'existe pas");
	}
	_contexte->add(_nom, _elem);
}
