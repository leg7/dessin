#include "Declaration.h"
#include <stdexcept>

Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, std::shared_ptr<Element> val, std::string nom):
	Instruction(contexte), _nom(nom), _val(val)
{
}

void Declaration::executer() const
{
	_contexte->add(_nom_special, _val);
	if (_nom != "") {
		if (_contexte->contains(_nom)) {
			throw std::invalid_argument("Impossible de declarer, la variable existe deja");
		}
		_contexte->add(_nom, _val);
	}
}

Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Carre> &e, const std::string &nom) noexcept: Instruction(contexte), _nom(nom), _val(e)
{
	_nom_special = "carre[" + std::to_string(contexte->nCarres++) + "]";
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Rectangle> &e, const std::string &nom) noexcept: Instruction(contexte), _nom(nom), _val(e)
{
	_nom_special = "rectangle[" + std::to_string(contexte->nRectangles++) + "]";
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Triangle> &e, const std::string &nom) noexcept: Instruction(contexte), _nom(nom), _val(e)
{
	_nom_special = "triangle" + std::to_string(contexte->nTriangles++) + "]";
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Cercle> &e, const std::string &nom) noexcept: Instruction(contexte), _nom(nom), _val(e)
{
	_nom_special = "cercle[" + std::to_string(contexte->nCercles++) + "]";
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Ellipse> &e, const std::string &nom) noexcept: Instruction(contexte), _nom(nom), _val(e)
{
	_nom_special = "ellipse[" + std::to_string(contexte->nEllipses++) + "]";
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Ligne> &e, const std::string &nom) noexcept: Instruction(contexte), _nom(nom), _val(e)
{
	_nom_special = "ligne[" + std::to_string(contexte->nLignes++) + "]";
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Chemin> &e, const std::string &nom) noexcept: Instruction(contexte), _nom(nom), _val(e)
{
	_nom_special = "chemin[" + std::to_string(contexte->nChemins++) + "]";
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Texte> &e, const std::string &nom) noexcept: Instruction(contexte), _nom(nom), _val(e)
{
	_nom_special = "texte[" + std::to_string(contexte->nTextes++) + "]";
}

// TODO: Utilser l'enum pour incrementer le bon indice automatiquement et un tableau de string avec la bonne chaine pour l'enum
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Forme> &e, const std::string &nom) noexcept: Instruction(contexte), _nom(nom), _val(e)
{
	switch (e->type()) {
		case Forme::Type::Carre: Declaration(contexte, std::dynamic_pointer_cast<Carre>(std::move(e)), ""); break;
		case Forme::Type::Cercle: Declaration(contexte, std::dynamic_pointer_cast<Cercle>(std::move(e)), ""); break;
		case Forme::Type::Chemin: Declaration(contexte, std::dynamic_pointer_cast<Chemin>(std::move(e)), ""); break;
		case Forme::Type::Ellipse: Declaration(contexte, std::dynamic_pointer_cast<Ellipse>(std::move(e)), ""); break;
		case Forme::Type::Ligne: Declaration(contexte, std::dynamic_pointer_cast<Ligne>(std::move(e)), ""); break;
		case Forme::Type::Rectangle: Declaration(contexte, std::dynamic_pointer_cast<Rectangle>(std::move(e)), ""); break;
		case Forme::Type::Texte: Declaration(contexte, std::dynamic_pointer_cast<Texte>(std::move(e)), ""); break;
		case Forme::Type::Triangle: Declaration(contexte, std::dynamic_pointer_cast<Triangle>(std::move(e)), ""); break;
	}
}

