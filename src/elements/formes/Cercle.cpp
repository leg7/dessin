#include "Cercle.h"

std::string Cercle::to_svg() const {
	return std::string("<circle ")
		+ "cx=\"" + std::to_string(_points[0].x) + "\" "
		+ "cy=\"" + std::to_string(_points[0].y) + "\" "
		+ "r=\"" + std::to_string(_rayon) + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Cercle::centre() const {
	return Point { _points[0].x, _points[0].y };
}
