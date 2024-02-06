#include "affectation.hh"
#include "contexte.hh"

Affectation::Affectation(std::string const& identifiant, ExpressionPtr valeur)
    : _identifiant(identifiant), _valeur(valeur)
{}

void Affectation::executer(Contexte &contexte) const {
    contexte.get(_identifiant) = _valeur->calculer(contexte);
}
