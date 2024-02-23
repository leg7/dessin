#include "Forme.h"

Forme::Forme(Type t) noexcept: _type(t) {}

Forme::Forme(Proprietes const& prop, Type t) noexcept: _prop(prop), _type(t) {}

double Forme::toDouble() const noexcept
{
	return 1.0;
}

void Forme::setProprietes(const Proprietes &p) noexcept
{
	_prop = p;
}


Forme::Type Forme::type() const noexcept
{
	return _type;
}

std::string Forme::proprietes_svg() const {
	return "";
}
