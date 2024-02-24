#include "Ligne.h"

std::string Ligne::to_svg() const {
	return std::string("<line ")
		+ "x1=\"" + std::to_string(_points[0].x) + "\" "
		+ "y1=\"" + std::to_string(_points[0].y) + "\" "
		+ "x2=\"" + std::to_string(_points[1].x) + "\" "
		+ "y2=\"" + std::to_string(_points[1].y) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Ligne::centre() const {
	return Point { (_points[0].x + _points[1].x) * .5, (_points[0].y + _points[1].y) * .5 };
}
