#include "Declaration.h"

void Declaration::executer() const noexcept
{
	_contexte->add(_nom, _val);
}

Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Carre> &e) noexcept: Instruction(contexte)
{
	_nom = "carre[" + std::to_string(contexte->nCarres++) + "]";
	_val = e;
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Rectangle> &e) noexcept: Instruction(contexte)
{
	_nom = "rectangle[" + std::to_string(contexte->nRectangles++) + "]";
	_val = e;
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Triangle> &e) noexcept: Instruction(contexte)
{
	_nom = "triangle" + std::to_string(contexte->nTriangles++) + "]";
	_val = e;
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Cercle> &e) noexcept: Instruction(contexte)
{
	_nom = "cercle[" + std::to_string(contexte->nCercles++) + "]";
	_val = e;
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Ellipse> &e) noexcept: Instruction(contexte)
{
	_nom = "ellipse[" + std::to_string(contexte->nEllipses++) + "]";
	_val = e;
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Ligne> &e) noexcept: Instruction(contexte)
{
	_nom = "ligne[" + std::to_string(contexte->nLignes++) + "]";
	_val = e;
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Chemin> &e) noexcept: Instruction(contexte)
{
	_nom = "chemin[" + std::to_string(contexte->nChemins++) + "]";
	_val = e;
}
Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Texte> &e) noexcept: Instruction(contexte)
{
	_nom = "texte[" + std::to_string(contexte->nTextes++) + "]";
	_val = e;
}

