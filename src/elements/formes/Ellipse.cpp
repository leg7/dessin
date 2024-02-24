#include "Ellipse.h"

std::string Ellipse::to_svg() const {
	return std::string("<ellipse ")
		+ "cx=\"" + std::to_string(_points[0].x) + "\" "
		+ "cy=\"" + std::to_string(_points[0].y) + "\" "
		+ "rx=\"" + std::to_string(_longueur) + "\" "
		+ "ry=\"" + std::to_string(_hauteur) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Ellipse::centre() const {
	return Point {_points[0].x, _points[0].y};
}
