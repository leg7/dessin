#include "Element.h"

class Taille: public Element
{
	double _l, _h;
	public:
	Taille(const double l, const double h);
	virtual double toDouble() const noexcept override;
	virtual Type type() const noexcept override { return Type::Taille; }
};
