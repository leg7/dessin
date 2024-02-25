#include "Rectangle.h"

std::string Rectangle::to_svg() const {
    return std::string("<polygon ")
		+ "points=\""
        + std::to_string(_points[0]->eval()->toDouble()) + ',' + std::to_string(_points[1]->eval()->toDouble()) + ' '
        + std::to_string(_points[2]->eval()->toDouble()) + ',' + std::to_string(_points[3]->eval()->toDouble()) + ' '
        + std::to_string(_points[4]->eval()->toDouble()) + ',' + std::to_string(_points[5]->eval()->toDouble()) + ' '
        + std::to_string(_points[6]->eval()->toDouble()) + ',' + std::to_string(_points[7]->eval()->toDouble())
        + "\" "
		+ proprietes_svg()
		+ "/>";
}

Forme::Point Rectangle::centre() const {
	Point result { 0, 0 };

	for (int i = 0; i < 8; i += 2) {
		result.x += _points[i]->eval()->toDouble();
		result.y += _points[i+1]->eval()->toDouble();
	}

	result.x /= 4.;
	result.y /= 4.;

	return result;
}
