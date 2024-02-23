#include "Ellipse.h"

std::string Ellipse::to_svg() const {
	return std::string("<ellipse ")
		+ "cx=\"" + std::to_string(_x1) + "\" "
		+ "cy=\"" + std::to_string(_y1) + "\" "
		+ "rx=\"" + std::to_string(_longueur) + "\" "
		+ "ry=\"" + std::to_string(_hauteur) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Ellipse::centre() const {
	return Point {_x1, _y1};
}
