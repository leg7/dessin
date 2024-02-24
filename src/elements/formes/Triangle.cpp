#include "Triangle.h"

std::string Triangle::to_svg() const {
	return std::string("<polygon ")
		+ "x1=\"" + std::to_string(_points[0].x) + "\" "
		+ "y1=\"" + std::to_string(_points[0].y - _hauteur) + "\" "
		+ "x2=\"" + std::to_string(_points[0].x - _longueur * .5) + "\" "
		+ "y2=\"" + std::to_string(_points[0].y) + "\" "
		+ "x3=\"" + std::to_string(_points[0].x + _longueur * .5) + "\" "
		+ "y3=\"" + std::to_string(_points[0].y) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Triangle::centre() const {
	return Point { _points[0].x, _points[0].y / 3. };
}
