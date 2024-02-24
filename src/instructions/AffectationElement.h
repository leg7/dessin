#include "Affectation.h"

class AffectationElement: public Affectation
{
	std::shared_ptr<Element> _elem;
	public:
	AffectationElement(const std::shared_ptr<Contexte> &c, const std::string &nom, const std::shared_ptr<Element> &e);
	virtual void executer() const override;
};
