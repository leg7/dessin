#include "Texte.h"

std::string Texte::to_svg() const {
	return std::string("<text ")
		+ "x=\"" + std::to_string(_points[0].x) + "\" "
		+ "y=\"" + std::to_string(_points[0].y) + "\" "
		+ "font-family=\"" + _police + "\" "
		+ "text-anchor=\"middle\" dominant-baseline=\"central\" "
		+ proprietes_svg()
		+ ">"
		+ _texte
		+ "</text>";
}

Forme::Point Texte::centre() const {
	return Point { _points[0].x, _points[0].y };
}
