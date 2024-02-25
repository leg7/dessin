#include "Triangle.h"

std::string Triangle::to_svg() const {
	return std::string("<polygon ")
		+ "x1=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ "y1=\"" + std::to_string(_points[0]->eval()->toDouble() - _hauteur->eval()->toDouble()) + "\" "
		+ "x2=\"" + std::to_string(_points[0]->eval()->toDouble() - _longueur->eval()->toDouble() * .5) + "\" "
		+ "y2=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ "x3=\"" + std::to_string(_points[0]->eval()->toDouble() + _longueur->eval()->toDouble() * .5) + "\" "
		+ "y3=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Triangle::centre() const {
	return Point { _points[0]->eval()->toDouble(), _points[0]->eval()->toDouble() / 3. };
}
