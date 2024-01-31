#include "rectangle.hh"

std::string Rectangle::to_svg() const {
    return "<polygon points=\""
        + coordonnees[0] + ',' + coordonnees[1]
        + coordonnees[2] + ',' + coordonnees[3]
        + coordonnees[4] + ',' + coordonnees[5]
        + coordonnees[6] + ',' + coordonnees[7]
        + "\">";
}
