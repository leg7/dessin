#include "Forme.h"

double Forme::toDouble() const noexcept
{
	return 1.0;
}

Forme::messageSetPropriete::messageSetPropriete(const messageSetPropriete &m)
{
	if (isFloatPropriete(m.propriete)) {
		f = m.f;
	} else if (isCouleurPropriete(m.propriete)) {
		c = m.c;
	} else {
		pointData.val = m.pointData.val;
		pointData.ind = m.pointData.ind;
		pointData.isX = m.pointData.isX;
	}
	propriete = m.propriete;
}

void Forme::setPropriete(const messageSetPropriete &m) noexcept
{
	switch (m.propriete) {
		case Propriete::Point: if (m.pointData.isX) _points[m.pointData.ind].x = m.pointData.val; else _points[m.pointData.ind].y = m.pointData.val; break;
		case Propriete::Opacite: _opacite = m.f; break;
		case Propriete::Rotation: _rotation = m.f; break;
		case Propriete::Epaisseur: _epaisseur = m.f; break;
		case Propriete::Couleur: _couleur = m.c; break;
		case Propriete::Remplissage: _remplissage = m.c; break;
		default: exit(69);
	}
}

bool Forme::isCouleurPropriete(Propriete p) noexcept
{
	const auto tmp = static_cast<int>(p);
	return tmp >= enumProprieteCouleurStart && tmp < enumProprieteFloatStart;
}

std::string Forme::proprietes_svg() const {
	Point c = centre();
	return "stroke=\"" + _couleur.to_string() + "\" "
		+ "fill=\"" + _remplissage.to_string() + "\" "
		+ "stroke-opacity=\"" + std::to_string(_opacite) + "\" "
		+ "fill-opacity=\"" + std::to_string(_opacite) + "\" "
		+ "stroke-width=\"" + std::to_string(_epaisseur) + "\" "
		+ "transform=\"rotate(" + std::to_string(_rotation) + "," + std::to_string(c.x) + "," + std::to_string(c.y) + ")\" "
		;
}
