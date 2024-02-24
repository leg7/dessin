#include "AffectationElement.h"
#include <stdexcept>

AffectationElement::AffectationElement(const std::shared_ptr<Contexte> &c, const std::string &nom, const std::shared_ptr<Element> &e):
	Affectation(c, nom), _elem(e)
{
}

void AffectationElement::executer() const
{
	if (!_contexte->contains(_nom)) {
		throw std::invalid_argument("Impossible d'affecter, la variable n'existe pas");
	}
	_contexte->add(_nom, _elem);
}
