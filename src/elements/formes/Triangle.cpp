#include "Triangle.h"

std::string Triangle::to_svg() const {
	return std::string("<polygon ")
		+ "x1=\"" + std::to_string(_x1) + "\" "
		+ "y1=\"" + std::to_string(_y1 - _hauteur) + "\" "
		+ "x2=\"" + std::to_string(_x1 - _longueur * .5) + "\" "
		+ "y2=\"" + std::to_string(_y1) + "\" "
		+ "x3=\"" + std::to_string(_x1 + _longueur * .5) + "\" "
		+ "y3=\"" + std::to_string(_y1) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Triangle::centre() const {
	return Point { _x1, _y1 / 3. };
}
