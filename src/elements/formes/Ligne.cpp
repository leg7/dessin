#include "Ligne.h"

std::string Ligne::to_svg() const {
	return std::string("<line ")
		+ "x1=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ "y1=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ "x2=\"" + std::to_string(_points[1]->eval()->toDouble()) + "\" "
		+ "y2=\"" + std::to_string(_points[1]->eval()->toDouble()) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Ligne::centre() const {
	return Point { (_points[0]->eval()->toDouble() + _points[1]->eval()->toDouble()) * .5, (_points[0]->eval()->toDouble() + _points[1]->eval()->toDouble()) * .5 };
}
