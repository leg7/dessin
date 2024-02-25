#include "Affectation.h"

class AffectationPropriete: public Affectation
{
	Forme::messageSetPropriete _m;
	std::shared_ptr<Expression> _offset;
	public:
	AffectationPropriete(const std::shared_ptr<Contexte> &contexte,
			const std::string &nom,
			Forme::messageSetPropriete &m,
			const std::shared_ptr<Expression> &offset = nullptr);
	void executer() const override;
};
