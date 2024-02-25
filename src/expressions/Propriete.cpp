#include "Propriete.h"
#include "../elements/ElementPrimitif.h"
#include "../elements/formes/Carre.h"

std::shared_ptr<Element> Propriete::eval() const noexcept
{
	const auto f = _c->atForme(_key);
	switch (_prop) {
		case Forme::Propriete::Couleur: return std::shared_ptr<Couleur>(&f->_couleur);
		case Forme::Propriete::Remplissage: return std::shared_ptr<Couleur>(&f->_remplissage);
		case Forme::Propriete::Opacite: return std::shared_ptr<ElementPrimitif<double>>(&f->_opacite);
		case Forme::Propriete::Rotation: return std::shared_ptr<ElementPrimitif<double>>(&f->_opacite);
		case Forme::Propriete::Epaisseur: return std::shared_ptr<ElementPrimitif<double>>(&f->_opacite);
		case Forme::Propriete::Taille: return std::shared_ptr<ElementPrimitif<double>>(&std::dynamic_pointer_cast<Carre>(f)->_taille);
		case Forme::Propriete::Point: return std::shared_ptr<ElementPrimitif<double>>(_isX ? &f->_points[_index].x : &f->_points[_index].y);
	}
	return nullptr;
}
