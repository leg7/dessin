#include "AffectationExpression.h"
#include <stdexcept>

AffectationExpression::AffectationExpression(const std::shared_ptr<Contexte> &c, const std::string &nom, const std::shared_ptr<Expression> &e):
	Affectation(c, nom), _expr(e)
{
}

void AffectationExpression::executer() const
{
	if (!_contexte->contains(_nom)) {
		throw std::invalid_argument("Impossible d'affecter, la variable n'existe pas");
	}
	_contexte->rm(_nom);
	_contexte->add(_nom, _expr->eval());
}
