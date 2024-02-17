#pragma once
#include "Instruction.h"
#include "../elements/Element.h"
#include "../Contexte.h"
#include "../elements/formes/Formes.h"
#include <string>

class Declaration: public Instruction
{
	int nCarres = 0, nRectangles = 0, nTriangles = 0, nCercles = 0, nEllipses = 0, nLignes = 0, nChemins = 0, nTextes = 0;
	std::string _nom;
	std::shared_ptr<Element> _val;

	public:
	Declaration(const std::shared_ptr<Contexte> &contexte,
			std::string nom,
			std::shared_ptr<Element> val) noexcept:
		Instruction(contexte), _nom(nom), _val(val) {}

	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Carre> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Rectangle> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Triangle> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Cercle> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Ellipse> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Ligne> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Chemin> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Texte> &e) noexcept;

	virtual void executer() const noexcept override;
};
