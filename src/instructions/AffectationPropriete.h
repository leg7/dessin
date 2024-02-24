#include "Affectation.h"

class AffectationPropriete: public Affectation
{
	Forme::messageSetPropriete _m;
	public:
	AffectationPropriete(const std::shared_ptr<Contexte> &contexte, const std::string &nom, Forme::messageSetPropriete &m);
	void executer() const override;
};
