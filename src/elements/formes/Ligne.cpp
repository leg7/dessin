#include "Ligne.h"

std::string Ligne::to_svg() const {
	return std::string("<line ")
		+ "x1=\"" + std::to_string(_points[0].x.toDouble()) + "\" "
		+ "y1=\"" + std::to_string(_points[0].y.toDouble()) + "\" "
		+ "x2=\"" + std::to_string(_points[1].x.toDouble()) + "\" "
		+ "y2=\"" + std::to_string(_points[1].y.toDouble()) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Ligne::centre() const {
	return Point { (_points[0].x.toDouble() + _points[1].x.toDouble()) * .5, (_points[0].y.toDouble() + _points[1].y.toDouble()) * .5 };
}
