#include "Triangle.h"

std::string Triangle::to_svg() const {
	return std::string("<polygon ")
		+ "x1=\"" + std::to_string(_points[0].x.toDouble()) + "\" "
		+ "y1=\"" + std::to_string(_points[0].y.toDouble() - _hauteur) + "\" "
		+ "x2=\"" + std::to_string(_points[0].x.toDouble() - _longueur * .5) + "\" "
		+ "y2=\"" + std::to_string(_points[0].y.toDouble()) + "\" "
		+ "x3=\"" + std::to_string(_points[0].x.toDouble() + _longueur * .5) + "\" "
		+ "y3=\"" + std::to_string(_points[0].y.toDouble()) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Triangle::centre() const {
	return Point { _points[0].x.toDouble(), _points[0].y.toDouble() / 3. };
}
