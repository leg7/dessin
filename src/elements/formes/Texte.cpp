#include "Texte.h"

std::string Texte::to_svg() const {
	return std::string("<text ")
		+ "x=\"" + std::to_string(_x1) + "\" "
		+ "y=\"" + std::to_string(_y1) + "\" "
		+ "font-family=\"" + _police + "\" "
		+ "text-anchor=\"middle\" dominant-baseline=\"central\" "
		+ proprietes_svg()
		+ ">"
		+ _texte
		+ "</text>";
}

Forme::Point Texte::centre() const {
	return Point { _x1, _y1 };
}
