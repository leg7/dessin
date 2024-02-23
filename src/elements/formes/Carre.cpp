#include "Carre.h"

std::string Carre::to_svg() const {
	return std::string("<rect ")
		+ "x=\"" + std::to_string(_x1) + "\" "
		+ "y=\"" + std::to_string(_y1) + "\" "
		+ "width=\"" + std::to_string(_taille) + "\" "
		+ "height=\"" + std::to_string(_taille) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Carre::centre() const {
	return Point { _x1 + _taille * .5, _y1 + _taille * .5 };
}
