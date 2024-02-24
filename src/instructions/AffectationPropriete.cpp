#include "AffectationPropriete.h"
#include <stdexcept>

AffectationPropriete::AffectationPropriete(const std::shared_ptr<Contexte> &contexte, const std::string &nom, Forme::messageSetPropriete &m):
	Affectation(contexte, nom), _m(m)
{
}

void AffectationPropriete::executer() const
{
	auto tmp = _contexte->at(_nom);
	if (Element::isFormeType(tmp->type())) {
		throw std::invalid_argument("Impossible d'affecter une propriete a un element qui n'est pas un forme");
	}
	std::dynamic_pointer_cast<Forme>(tmp)->setPropriete(_m);
}
