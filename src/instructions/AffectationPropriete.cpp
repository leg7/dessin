#include "AffectationPropriete.h"
#include <stdexcept>

AffectationPropriete::AffectationPropriete(const std::shared_ptr<Contexte> &contexte, const std::string &nom, Forme::messageSetPropriete &m, const std::shared_ptr<Expression> &offset):
	Affectation(contexte, nom), _m(m), _offset(offset)
{
}

void AffectationPropriete::executer() const
{
	std::shared_ptr<Element> tmp;
	if (_offset != nullptr) {
		tmp = _contexte->at(_nom + std::to_string(_offset->eval()->toDouble()));
	} else {
		tmp = _contexte->at(_nom);
	}

	if (!Element::isFormeType(tmp->type())) {
		throw std::invalid_argument("Impossible d'affecter une propriete a un element qui n'est pas un forme");
	}
	std::dynamic_pointer_cast<Forme>(tmp)->recevoirMessage(_m);
}
