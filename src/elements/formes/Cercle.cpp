#include "Cercle.h"

std::string Cercle::to_svg() const {
	return std::string("<circle ")
		+ "cx=\"" + std::to_string(_points[0].x.toDouble()) + "\" "
		+ "cy=\"" + std::to_string(_points[0].y.toDouble()) + "\" "
		+ "r=\"" + std::to_string(_rayon) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Cercle::centre() const {
	return Point { _points[0].x.toDouble(), _points[0].y.toDouble() };
}
