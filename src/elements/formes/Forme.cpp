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

void Forme::setPropriete(TypePropriete type, std::string const& valeur) noexcept {
	_proprietes[static_cast<int>(type)] = valeur;
}

Forme::Type Forme::type() const noexcept
{
	return _type;
}

std::string Forme::proprietes_svg() const {
	Point c = centre();
	return "stroke=\"" + _proprietes[static_cast<int>(TypePropriete::Couleur)] + "\" "
		+ "fill=\"" + _proprietes[static_cast<int>(TypePropriete::Remplissage)] + "\" "
		+ "stroke-opacity=\"" + _proprietes[static_cast<int>(TypePropriete::Opacite)] + "\" "
		+ "fill-opacity=\"" + _proprietes[static_cast<int>(TypePropriete::Opacite)] + "\" "
		+ "stroke-width=\"" + _proprietes[static_cast<int>(TypePropriete::Epaisseur)] + "\" "
		+ "transform=\"rotate(" + _proprietes[static_cast<int>(TypePropriete::Rotation)] + "," + std::to_string(c.x) + "," + std::to_string(c.y) + ")\" " 
		;
}
