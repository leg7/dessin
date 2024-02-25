#include "Forme.h"
#include "../Couleur.h"
#include <cmath>

void Forme::recevoirMessage(const messageSetPropriete &m)
{
	if (m.propriete == Propriete::Point && m.indexPoint >= 0) {
		_points[m.indexPoint] = m.valeure;
	} else {
		_proprietesStandard[static_cast<int8_t>(m.propriete)] = m.valeure;
	}
}

std::shared_ptr<Expression> Forme::getPropriete(Propriete p, int indexPoint)
{
	if (p == Propriete::Point && indexPoint >= 0) {
		return _points[indexPoint];
	} else {
		return _proprietesStandard[static_cast<int8_t>(p)];
	}
}

double Forme::toDouble() const noexcept
{
	return 1.0;
}

std::string Forme::proprietes_svg() const {
	Point c = centre();
	return "stroke=\"" + std::dynamic_pointer_cast<Couleur>(couleur()->eval())->to_string() + "\" "
		+ "fill=\"" + std::dynamic_pointer_cast<Couleur>(remplissage()->eval())->to_string() + "\" "
		+ "stroke-opacity=\"" + std::to_string(opacite()->eval()->toDouble() * 0.01) + "\" "
		+ "fill-opacity=\"" + std::to_string(opacite()->eval()->toDouble()) + "\" "
		+ "stroke-width=\"" + std::to_string(epaisseur()->eval()->toDouble()) + "\" "
		+ "transform=\"rotate(" + std::to_string(fmod(rotation()->eval()->toDouble(), 360.0)) + "," + std::to_string(c.x) + "," + std::to_string(c.y) + ")\" "
		;
}
