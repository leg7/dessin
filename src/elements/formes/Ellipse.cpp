#include "Ellipse.h"

std::string Ellipse::to_svg() const {
	return std::string("<ellipse ")
		+ "cx=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ "cy=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ "rx=\"" + std::to_string(_longueur->eval()->toDouble()) + "\" "
		+ "ry=\"" + std::to_string(_hauteur->eval()->toDouble()) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Ellipse::centre() const {
	return Point {_points[0]->eval()->toDouble(), _points[0]->eval()->toDouble()};
}
