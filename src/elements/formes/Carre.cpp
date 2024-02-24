#include "Carre.h"

std::string Carre::to_svg() const {
	return std::string("<rect ")
		+ "x=\"" + std::to_string(_points[0].x) + "\" "
		+ "y=\"" + std::to_string(_points[0].y) + "\" "
		+ "width=\"" + std::to_string(_taille) + "\" "
		+ "height=\"" + std::to_string(_taille) + "\" "
		+ proprietes_svg()
		+ "/>";
}


// Pareil que dans Forme mais supporte l'attribut taille
void Carre::setPropriete(const messageSetPropriete &m) noexcept
{
	switch (m.propriete) {
		case Propriete::Point: if (m.pointData.isX) _points[m.pointData.ind].x = m.pointData.val; else _points[m.pointData.ind].y = m.pointData.val; break;
		case Propriete::Opacite: _opacite = m.f; break;
		case Propriete::Rotation: _rotation = m.f; break;
		case Propriete::Epaisseur: _epaisseur = m.f; break;
		case Propriete::Couleur: _couleur = m.c; break;
		case Propriete::Remplissage: _remplissage = m.c; break;
		case Propriete::Taille: _taille = m.f; break;
		default: exit(69);
	}
}

Forme::Point Carre::centre() const {
	return Point { _points[0].x + _taille * .5, _points[0].y + _taille * .5 };
}
