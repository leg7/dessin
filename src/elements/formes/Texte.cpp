#include "Texte.h"

std::string Texte::to_svg() const {
	return std::string("<text ")
		+ "x=\"" + std::to_string(_x1) + "\" "
		+ "y=\"" + std::to_string(_y1) + "\" "
		+ "font-family=\"" + _police + "\" "
		+ proprietes_svg()
		+ ">"
		+ _texte
		+ "</text>";
}
