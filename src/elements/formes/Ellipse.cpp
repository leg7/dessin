#include "Ellipse.h"

std::string Ellipse::to_svg() const {
	return std::string("<ellipse ")
		+ "cx=\"" + std::to_string(_points[0].x.toDouble()) + "\" "
		+ "cy=\"" + std::to_string(_points[0].y.toDouble()) + "\" "
		+ "rx=\"" + std::to_string(_longueur) + "\" "
		+ "ry=\"" + std::to_string(_hauteur) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Ellipse::centre() const {
	return Point {_points[0].x.toDouble(), _points[0].y.toDouble()};
}
