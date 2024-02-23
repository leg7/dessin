#include "Rectangle.h"

std::string Rectangle::to_svg() const {
    return std::string("<polygon ")
		+ "points=\""
        + std::to_string(_coordonnees[0]) + ',' + std::to_string(_coordonnees[1]) + ' '
        + std::to_string(_coordonnees[2]) + ',' + std::to_string(_coordonnees[3]) + ' '
        + std::to_string(_coordonnees[4]) + ',' + std::to_string(_coordonnees[5]) + ' '
        + std::to_string(_coordonnees[6]) + ',' + std::to_string(_coordonnees[7])
        + "\" "
		+ proprietes_svg()
		+ "/>";
}
