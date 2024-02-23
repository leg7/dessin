#include "Ligne.h"

std::string Ligne::to_svg() const {
	return std::string("<line ")
		+ "x1=\"" + std::to_string(_x1) + "\" "
		+ "y1=\"" + std::to_string(_y1) + "\" "
		+ "x2=\"" + std::to_string(_x2) + "\" "
		+ "y2=\"" + std::to_string(_y2) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Ligne::centre() const {
	return Point { (_x1 + _x2) * .5, (_y1 + _y2) * .5 };
}
