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
	Point c = centre();
	return "stroke=\"" + _prop.couleur.to_string() + "\" "
		+ "fill=\"" + _prop.remplissage.to_string() + "\" "
		+ "stroke-opacity=\"" + std::to_string(_prop.opacite) + "\" "
		+ "fill-opacity=\"" + std::to_string(_prop.opacite) + "\" "
		+ "stroke-width=\"" + std::to_string(_prop.epaisseur) + "\" "
		+ "transform=\"rotate(" + std::to_string(_prop.rotation) + "," + std::to_string(c.x) + "," + std::to_string(c.y) + ")\" "
		;
}
