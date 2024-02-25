#include "Affectation.h"
#include "../expressions/Expression.h"

class AffectationExpression: public Affectation
{
	std::shared_ptr<Expression> _expr;
	public:
	AffectationExpression(const std::shared_ptr<Contexte> &c, const std::string &nom, const std::shared_ptr<Expression> &e);
	virtual void executer() const override;
};
