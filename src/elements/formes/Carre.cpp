#include "Carre.h"

void Carre::recevoirMessage(const messageSetPropriete &m)
{
	if (m.propriete == Propriete::Taille) {
		_taille = m.valeure;
	} else {
		Forme::recevoirMessage(m);
	}
}

std::string Carre::to_svg() const {
	return std::string("<rect ")
		+ "x=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ "y=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ "width=\"" + std::to_string(_taille->eval()->toDouble()) + "\" "
		+ "height=\"" + std::to_string(_taille->eval()->toDouble()) + "\" "
		+ proprietes_svg()
		+ "/>";
}


Forme::Point Carre::centre() const {
	return Point {
		_points[0]->eval()->toDouble() + _taille->eval()->toDouble() * .5,
		_points[1]->eval()->toDouble() + _taille->eval()->toDouble() * .5
	};
}
