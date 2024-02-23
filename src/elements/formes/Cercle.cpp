#include "Cercle.h"

std::string Cercle::to_svg() const {
	return std::string("<circle ")
		+ "cx=\"" + std::to_string(_x1) + "\" "
		+ "cy=\"" + std::to_string(_y1) + "\" "
		+ "r=\"" + std::to_string(_rayon) + "\" "
		+ proprietes_svg()
		+ "/>";
}
