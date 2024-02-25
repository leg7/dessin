#include "Cercle.h"

std::string Cercle::to_svg() const {
	return std::string("<circle ")
		+ "cx=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ "cy=\"" + std::to_string(_points[0]->eval()->toDouble()) + "\" "
		+ "r=\"" + std::to_string(_rayon->eval()->toDouble()) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Cercle::centre() const {
	return Point { _points[0]->eval()->toDouble(), _points[0]->eval()->toDouble() };
}
